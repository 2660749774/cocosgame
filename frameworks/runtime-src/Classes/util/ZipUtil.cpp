#include "ZipUtil.h"

#define BUFFER_SIZE    8192
#define MAX_FILENAME   512



ZipUtil::ZipUtil(const std::string& zipFilePath, const std::string& outputDir)
: _zipFilePath(zipFilePath)
, _outputDir(outputDir)
, _state(kZipStateIdle)
, _totalEntryNum(0)
, _uncompressEntryNum(0)
, _errorCode(0)
{
	_fileUtils = FileUtils::getInstance();
}

ZipUtil::~ZipUtil(void)
{
	if (_listener)
	{
#if (CC_LUA_ENGINE_ENABLED > 0)
		LuaEngine::getInstance()->removeScriptHandler(_listener);
#endif
	}
}

#if CC_LUA_ENGINE_ENABLED > 0
static ZipUtil* createWithUrlLua(LUA_FUNCTION listener,
	const std::string &zipFilePath,
	const std::string &outputDir) 
{
	ZipUtil *_zipUtil = new ZipUtil(zipFilePath, outputDir);
	_zipUtil->listener = listener;
	return _zipUtil;
}
#endif

bool ZipUtil::decompress()
{
	// 判断文件是否存在
	if (!_fileUtils->isFileExist(_zipFilePath)) {
		CCLOG("zip file not exists, file %s\n", _zipFilePath.c_str());
		_state = kZipStateFailed;
		_errorCode = kZip_FILE_NOTEXISTS;
		_error = "file not exists";
		return false;
	}

	// 判断输出目录是否存在
	if (!_fileUtils->isDirectoryExist(_outputDir)) {
		CCLOG("output dir not exists, dir %s, create the dir\n", _outputDir.c_str());
		if (!_fileUtils->createDirectory(basename(_outputDir))) {
			CCLOG("can not create directory %s\n", _outputDir.c_str());
			_state = kZipStateFailed;
			_errorCode = kZip_DIR_CANNOT_CREATE;
			_error = "create directory failed";
			return false;
		}
	}

	// 规范输出目录
	std::string outDir;
	if (_outputDir[_outputDir.length - 1] != "/") {
		outDir = _outputDir + "/";
	}
	else {
		outDir = _outputDir;
	}

	// Open the zip file
	unzFile zipfile = unzOpen(FileUtils::getInstance()->getSuitableFOpen(_zipFilePath).c_str());
	if (!zipfile)
	{
		CCLOG("can not open downloaded zip file %s", _zipFilePath.c_str());
		_state = kZipStateFailed;
		_errorCode = kZip_ZIP_CANNOT_READ;
		_error = "can not open zip file";
		return false;
	}

	// Get info about the zip file
	unz_global_info global_info;
	if (unzGetGlobalInfo(zipfile, &global_info) != UNZ_OK)
	{
		CCLOG("can not read file global info of %s\n", _zipFilePath.c_str());
		unzClose(zipfile);
		_state = kZipStateFailed;
		_errorCode = kZip_ZIP_CANNOT_READGLOBALINFO;
		_error = "can not read zip file global info";
		return false;
	}
	// Buffer to hold data read from the zip file
	char readBuffer[BUFFER_SIZE];
	// Loop to extract all files.
	uLong i;
	for (i = 0; i < global_info.number_entry; ++i)
	{
		// Get info about current file.
		unz_file_info fileInfo;
		char fileName[MAX_FILENAME];
		if (unzGetCurrentFileInfo(zipfile,
			&fileInfo,
			fileName,
			MAX_FILENAME,
			NULL,
			0,
			NULL,
			0) != UNZ_OK)
		{
			CCLOG("can not read compressed file info\n");
			unzClose(zipfile);
			_state = kZipStateFailed;
			_errorCode = kZip_ZIP_CANNOT_READ;
			_error = "can not read compressed file info";
			return false;
		}

		const std::string fullPath = outDir + fileName;

		// Check if this entry is a directory or a file.
		const size_t filenameLength = strlen(fileName);
		if (fileName[filenameLength - 1] == '/')
		{
			//There are not directory entry in some case.
			//So we need to create directory when decompressing file entry
			if (!_fileUtils->createDirectory(basename(fullPath)))
			{
				// Failed to create directory
				CCLOG("can not create directory %s\n", fullPath.c_str());
				unzClose(zipfile);
				_state = kZipStateFailed;
				_errorCode = kZip_DIR_CANNOT_CREATE;
				_error = "can not create directory";
				return false;
			}
		}
		else
		{
			// Entry is a file, so extract it.
			// Open current file.
			if (unzOpenCurrentFile(zipfile) != UNZ_OK)
			{
				CCLOG("can not extract file %s\n", fileName);
				unzClose(zipfile);
				_state = kZipStateFailed;
				_errorCode = kZip_ZIP_CANNOT_EXTRACT;
				_error = "can not extract file";
				return false;
			}

			// Create a file to store current file.
			FILE *out = fopen(FileUtils::getInstance()->getSuitableFOpen(fullPath).c_str(), "wb");
			if (!out)
			{
				CCLOG("can not create decompress destination file %s\n", fullPath.c_str());
				unzCloseCurrentFile(zipfile);
				unzClose(zipfile);
				_state = kZipStateFailed;
				_errorCode = kZip_DIR_CANNOT_CREATE;
				_error = "can not create decompress destination file";
				return false;
			}

			// Write current file content to destinate file.
			int error = UNZ_OK;
			do
			{
				error = unzReadCurrentFile(zipfile, readBuffer, BUFFER_SIZE);
				if (error < 0)
				{
					CCLOG("can not read zip file %s, error code is %d\n", fileName, error);
					fclose(out);
					unzCloseCurrentFile(zipfile);
					unzClose(zipfile);
					_state = kZipStateFailed;
					_errorCode = kZip_ZIP_CANNOT_READ;
					_error = "can not read zip file error code is " + error;
					return false;
				}

				if (error > 0)
				{
					fwrite(readBuffer, error, 1, out);
				}
			} while (error > 0);

			fclose(out);
		}

		unzCloseCurrentFile(zipfile);

		// Goto next entry listed in the zip file.
		if ((i + 1) < global_info.number_entry)
		{
			if (unzGoToNextFile(zipfile) != UNZ_OK)
			{
				CCLOG("can not read next file for decompressing\n");
				unzClose(zipfile);
				_state = kZipStateFailed;
				_errorCode = kZip_ZIP_CANNOT_READ;
				_error = "can not read next file";
				return false;
			}
		}
	}

	unzClose(zipfile);
	return true;
}

std::string ZipUtil::basename(const std::string& path)
{
	size_t found = path.find_last_of("/\\");

	if (std::string::npos != found)
	{
		return path.substr(0, found);
	}
	else
	{
		return path;
	}
}