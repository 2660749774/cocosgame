#include "HTTPDownload.h"
#include "io.h"

HTTPDownload::~HTTPDownload(void)
{
	cleanup();
	if (_listener)
	{
#if (CC_LUA_ENGINE_ENABLED > 0)
		LuaEngine::getInstance()->removeScriptHandler(_listener);
#endif
	}
	// CCLOG("HTTPRequest[0x%04x] - request removed", s_id);
}

#if CC_LUA_ENGINE_ENABLED > 0
HTTPDownload *HTTPDownload::createWithUrlLua(LUA_FUNCTION listener,
	const char *url, const char *filePath)
{
	HTTPDownload *request = new HTTPDownload();
	request->_filePath = filePath;
	request->_url = url;
	request->initWithListener(listener, url);
	request->autorelease();
	return request;
}
#endif


#if CC_LUA_ENGINE_ENABLED > 0
bool HTTPDownload::initWithListener(LUA_FUNCTION listener, const char *url)
{
	_listener = listener;
	return initWithUrl(url);
}
#endif

bool HTTPDownload::initWithUrl(const char *url)
{
	CCAssert(url, "HTTPDownload::initWithUrl() - invalid url");
	_curl = curl_easy_init();
	curl_easy_setopt(_curl, CURLOPT_URL, url);
	curl_easy_setopt(_curl, CURLOPT_USERAGENT, "libcurl");
	curl_easy_setopt(_curl, CURLOPT_CONNECTTIMEOUT, 0);
	curl_easy_setopt(_curl, CURLOPT_TIMEOUT, 0);
	curl_easy_setopt(_curl, CURLOPT_NOSIGNAL, 1L);


	// CCLOG("HTTPRequest[0x%04x] - create request with url: %s", s_id, url);
	return true;
}

bool HTTPDownload::start()
{
	CCAssert(_state == kCCHTTPRequestStateIdle, "HTTPRequest::start() - request not idle");

	_state = kCCHTTPRequestStateInProgress;
	retain();

	if (_access(_filePath.c_str(), 0) == 0) { 
		// 以二进制形式追加
		_fp = fopen(_filePath.c_str(), "ab+");
	} else {
		// 二进制写
		_fp = fopen(_filePath.c_str(), "wb");
	}

	if (_fp == NULL) {
		// 如果文件初始化失败进行返回
		return false;
	}

	// 读取本地文件下载大小
	int use_resume = 0;
	long localFileLenth = getLocalFileLength(); //已经下载的大小
	if (localFileLenth > 0)
	{
		use_resume = 1;
	}

	//	curl_easy_setopt(_curl, CURLOPT_TIMEOUT, 0);  // 设置总下载时间，0表示无限
	curl_easy_setopt(_curl, CURLOPT_CONNECTTIMEOUT, 10); // 设置连接超时，默认10s
	curl_easy_setopt(_curl, CURLOPT_HEADERFUNCTION, getContentLengthCURL);
	curl_easy_setopt(_curl, CURLOPT_WRITEFUNCTION, writeDataCURL);   // 写文件回调方法
	curl_easy_setopt(_curl, CURLOPT_WRITEDATA, _fp); // 写入文件对象
	curl_easy_setopt(_curl, CURLOPT_RESUME_FROM, use_resume ? localFileLenth : 0);   // 从本地大小位置进行请求数据
	//	curl_easy_setopt(_curl, CURLOPT_RESUME_FROM_LARGE, (long long)(use_resume ? localFileLenth : 0)); // CURLOPT_RESUME_FROM_LARGE针对于大文件
	curl_easy_setopt(_curl, CURLOPT_NOPROGRESS, 0L);
	curl_easy_setopt(_curl, CURLOPT_PROGRESSFUNCTION, progressCURL); // 下载进度回调方法
	curl_easy_setopt(_curl, CURLOPT_PROGRESSDATA, this); // 传入本类对象

#ifdef _WINDOWS_

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8) || (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT)
	std::thread worker(requestCURL, this);
	worker.detach();

#else
	CreateThread(NULL,          // default security attributes
		0,             // use default stack size
		requestCURL,   // thread function name
		this,          // argument to thread function
		0,             // use default creation flags
		NULL);
#endif // CC_TARGET_PLATFORM == CC_PLATFORM_WP8

#else
	pthread_create(&_thread, NULL, requestCURL, this);
	pthread_detach(_thread);
#endif

	Director::getInstance()->getScheduler()->scheduleUpdate(this, 0, false);
	return true;
}

void HTTPDownload::setAcceptEncoding(int acceptEncoding)
{
	CCAssert(_state == kCCHTTPRequestStateIdle, "HTTPRequest::setAcceptEncoding() - request not idle");
	switch (acceptEncoding)
	{
	case kCCHTTPRequestAcceptEncodingGzip:
		curl_easy_setopt(_curl, CURLOPT_ACCEPT_ENCODING, "gzip");
		break;

	case kCCHTTPRequestAcceptEncodingDeflate:
		curl_easy_setopt(_curl, CURLOPT_ACCEPT_ENCODING, "deflate");
		break;

	default:
		curl_easy_setopt(_curl, CURLOPT_ACCEPT_ENCODING, "identity");
	}
}

void HTTPDownload::setConnectTimeout(int timeout)
{
	CCAssert(_state == kCCHTTPRequestStateIdle, "HTTPDownload::setTimeout() - request not idle");
	curl_easy_setopt(_curl, CURLOPT_CONNECTTIMEOUT, timeout);
}

int HTTPDownload::getState(void)
{
	return _state;
}

int HTTPDownload::getResponseStatusCode(void)
{
	CCAssert(_state == kCCHTTPRequestStateCompleted, "Request not completed");
	return _responseCode;
}

int HTTPDownload::getErrorCode(void)
{
	return _errorCode;
}

const string HTTPDownload::getErrorMessage(void)
{
	return _errorMessage;
}

void HTTPDownload::update(float dt)
{
	if (_state == kCCHTTPRequestStateInProgress)
	{
#if CC_LUA_ENGINE_ENABLED > 0
		if (_listener)
		{
			LuaValueDict dict;

			dict["name"] = LuaValue::stringValue("progress");
			dict["total"] = LuaValue::intValue((int)_dltotal);
			dict["dltotal"] = LuaValue::intValue((int)_dlnow);
			dict["request"] = LuaValue::ccobjectValue(this, "HTTPDownload");

			LuaStack *stack = LuaEngine::getInstance()->getLuaStack();
			stack->clean();
			stack->pushLuaValueDict(dict);
			stack->executeFunctionByHandler(_listener, 1);
		}
#endif
		return;
	}

	Director::getInstance()->getScheduler()->unscheduleAllForTarget(this);

#if CC_LUA_ENGINE_ENABLED > 0
	if (_listener)
	{
		LuaValueDict dict;

		switch (_state)
		{
		case kCCHTTPRequestStateCompleted:
			dict["name"] = LuaValue::stringValue("completed");
			break;

		case kCCHTTPRequestStateCancelled:
			dict["name"] = LuaValue::stringValue("cancelled");
			break;

		case kCCHTTPRequestStateFailed:
			dict["name"] = LuaValue::stringValue("failed");
			break;

		default:
			dict["name"] = LuaValue::stringValue("unknown");
		}
		dict["request"] = LuaValue::ccobjectValue(this, "HTTPDownload");
		LuaStack *stack = LuaEngine::getInstance()->getLuaStack();
		stack->clean();
		stack->pushLuaValueDict(dict);
		stack->executeFunctionByHandler(_listener, 1);
	}
#endif
}

int HTTPDownload::onProgress(double dltotal, double dlnow, double ultotal, double ulnow)
{
	_dltotal = dltotal + _localFileLength;
	_dlnow = dlnow + _localFileLength;
	_ultotal = ultotal;
	_ulnow = ulnow;

	return _state == kCCHTTPRequestStateCancelled ? 1 : 0;
}

// curl callback
#ifdef _WINDOWS_
DWORD WINAPI HTTPDownload::requestCURL(LPVOID userdata)
{
	static_cast<HTTPDownload*>(userdata)->onRequest();
	return 0;
}
#else // _WINDOWS_
void *HTTPDownload::requestCURL(void *userdata)
{
	static_cast<HTTPDownload*>(userdata)->onRequest();
	return NULL;
}
#endif // _WINDOWS_

// instance callback
void HTTPDownload::onRequest(void)
{
	CURLcode code = curl_easy_perform(_curl);
	curl_easy_getinfo(_curl, CURLINFO_RESPONSE_CODE, &_responseCode);


	curl_easy_cleanup(_curl);
	_curl = NULL;
	_errorCode = code;
	_errorMessage = (code == CURLE_OK) ? "" : curl_easy_strerror(code);
	_state = (code == CURLE_OK) ? kCCHTTPRequestStateCompleted : kCCHTTPRequestStateFailed;

	if (_fp != NULL) {
		fclose(_fp);
		_fp = NULL;
	}

}

size_t HTTPDownload::getContentLengthCURL(void *userdata, size_t size, size_t nmemb, void *data)
{
	return (size_t)(size * nmemb);
}

size_t HTTPDownload::writeDataCURL(void *buffer, size_t size, size_t nmemb, void *userdata)
{
	FILE *fp = (FILE*)userdata;
	size_t written = fwrite(buffer, size, nmemb, fp);
	return written;
}

int HTTPDownload::progressCURL(void *userdata, double dltotal, double dlnow, double ultotal, double ulnow)
{
	return static_cast<HTTPDownload*>(userdata)->onProgress(dltotal, dlnow, ultotal, ulnow);
}

void HTTPDownload::cleanup(void)
{
	_state = kCCHTTPRequestStateCleared;
	if (_curl)
	{
		curl_easy_cleanup(_curl);
		_curl = NULL;
	}
	if (_fp)
	{
		fclose(_fp);
		_fp = NULL;
	}
}

long HTTPDownload::getLocalFileLength()
{
	FILE *fp = fopen(_filePath.c_str(), "r");
	fseek(fp, 0, SEEK_END);
	long length = ftell(fp);
	fclose(fp);

	_localFileLength = length;
	return length;
}