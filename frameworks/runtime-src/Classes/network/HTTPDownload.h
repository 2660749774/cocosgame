#pragma once
#ifndef HTTPDownload_h
#define HTTPDownload_h

#include <string>
#include <thread>
#include "cocos2d.h"
#include "curl/curl.h"
#include "network/CCHTTPRequest.h"

using namespace std;
USING_NS_CC;

class HTTPDownload: Ref
{
public:
	#if CC_LUA_ENGINE_ENABLED > 0
		static HTTPDownload* createWithUrlLua(LUA_FUNCTION listener,
			const char *url,
			const char *filePath);
	#endif

	// ��ʼ����
	bool start();

	/** @brief Set accept encoding. */
	void setAcceptEncoding(int acceptEncoding);

	/** @brief Number of seconds to wait before timing out - default is 10. */
	void setConnectTimeout(int timeout);

	/** @brief Get the request state. */
	int getState(void);

	/** @brief Return HTTP status code. */
    int getResponseStatusCode(void);

	/** @brief Get error code. */
	int getErrorCode(void);

	/** @brief Get error message. */
	const string getErrorMessage(void);

	// ���º���
	virtual void update(float dt);

	// ��������
	~HTTPDownload(void);

private:
	// ���캯��
	HTTPDownload(void) 
	:_listener(0)
	, _state(kCCHTTPRequestStateIdle)
	, _errorCode(0)
	, _responseCode(0)
	, _dltotal(0)
	, _dlnow(0)
	, _ultotal(0)
	, _ulnow(0)
	, _localFileLength(0)
	{
	}

	// Lua�ص�����
	int _listener;

	// ״̬�ʹ�����
	int     _state;
	int     _errorCode;
	string  _errorMessage;
	int _responseCode;
	
	// url
	string _url;
	// ��������ļ�·��
	string _filePath;

	// ���ؽ������
	long _localFileLength;
	double _dltotal;
	double _dlnow;
	double _ultotal;
	double _ulnow;

	// curl���ļ����
	CURL *_curl;
	FILE *_fp;

	// ��ʼ������
#if CC_LUA_ENGINE_ENABLED > 0
	bool initWithListener(LUA_FUNCTION listener, const char *url);
#endif

	// ��ʼ������
	bool initWithUrl(const char *url);

	// ������
	void cleanup();

	// ���½���
	int onProgress(double dltotal, double dlnow, double ultotal, double ulnow);

	// ��ȡ�����ļ�����
	long getLocalFileLength();

	// �߳�ִ�з���
	void onRequest(void);

	// curl callback
#ifdef _WINDOWS_
	static DWORD WINAPI requestCURL(LPVOID userdata);
#else
	pthread_t _thread;
	static void *requestCURL(void *userdata);
#endif
	static size_t writeDataCURL(void *buffer, size_t size, size_t nmemb, void *userdata);
	static int progressCURL(void *userdata, double dltotal, double dlnow, double ultotal, double ulnow);
	static size_t getContentLengthCURL(void *userdata, size_t size, size_t nmemb, void *data);
};


#endif /* Header_h */