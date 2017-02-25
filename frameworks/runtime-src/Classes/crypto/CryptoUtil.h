//
//  CCCryptoUtil.hpp
//  CryptSample
//
//  Created by brightzamber on 2016/04/15.
//
//

#ifndef CryptoUtil_h
#define CryptoUtil_h

#include <string>
using namespace std;

class CryptoUtil {
public:
    CryptoUtil();
    ~CryptoUtil();
    
    // aes加密
    static std::string encryptAES256(std::string plaintext, int textLen, std::string key, int keyLen);

    // aes解密
    static std::string decryptAES256(std::string ciphertext, int textLen, std::string key, int keyLen);

    // base64Encode
    static std::string encodeBase64(std::string plaintext);

    // base64Decode
    static std::string decodeBase64(std::string ciphertext);

    // md5
    static std::string md5(std::string plaintext);

    // md5File
    static std::string md5File(std::string filePath);
};

#endif /* CryptoUtil_h */
