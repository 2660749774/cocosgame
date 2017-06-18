//
//  Header.h
//  game
//
//  Created by 王愿生 on 2016/12/29.
//
//

#ifndef ZipUtil_h
#define ZipUtil_h

#include <thread>
#include <string>
#include "cocos2d.h"
#include "unzip/unzip.h"
#include "platform/CCFileUtils.h"
#if CC_LUA_ENGINE_ENABLED > 0
#include "CCLuaEngine.h"
#endif

using namespace std;
USING_NS_CC;



#define kZipStateIdle                  0
#define kZipStateProgress              1
#define kZipStateCompleted             2
#define kZipStateFailed                3

#define kZip_OK     0
#define kZip_FILE_NOTEXISTS       1
#define kZip_FILE_CANNOT_CREATE       2
#define kZip_DIR_CANNOT_CREATE     3
#define kZip_ZIP_CANNOT_READ      4
#define kZip_ZIP_CANNOT_READGLOBALINFO      5
#define kZip_ZIP_CANNOT_EXTRACT   6

class ZipUtil : Ref
{
public:
	// 创建解压文件
#if CC_LUA_ENGINE_ENABLED > 0
	static ZipUtil* createWithUrlLua(LUA_FUNCTION listener,
		const std::string &zipFilePath, 
		const std::string &outputDir);
#endif

	// 解压文件
	bool decompress();
    
    // 异步解压缩
    bool decompressAsync();
    
    // 更新函数
    virtual void update(float dt);

    // 析构函数
    ~ZipUtil(void);

private:
	// 构造函数
	ZipUtil(const std::string& zipFilePath, const std::string& outputDir);

	// 文件工具类
	FileUtils *_fileUtils;

	// Lua回调函数
	int _listener;

	// 输出文件路径
	std::string _zipFilePath;
	std::string _outputDir;

	// 当前状态
	int _state;
	int _errorCode;
	std::string  _error;

	// 总实体个数
	int _totalEntryNum;
	// 已解压个数
	int _uncompressEntryNum;
    
#ifdef _WINDOWS_
    static DWORD WINAPI onDecompress(LPVOID userdata);
#else
    pthread_t _thread;
    static void *onDecompress(void *userdata);
#endif

	// 获取basename
	string basename(const std::string& path);
};


#endif /* Header_h */
