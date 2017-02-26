//
//  CCCryptoUtil.cpp
//  CryptSample
//
//  Created by brightzamber on 2016/04/15.
//
//

#include "CryptoUtil.h"
#include <iostream>
#include <iomanip>
#include <string>

#include "cryptopp/modes.h"
#include "cryptopp/aes.h"
#include "cryptopp/files.h"
#include "cryptopp/md5.h"
#include "cryptopp/hex.h"
#include "cryptopp/base64.h"

using namespace CryptoPP;

using namespace std;


CryptoUtil::CryptoUtil(){
}
CryptoUtil::~CryptoUtil(){
}

std::string CryptoUtil::encryptAES256(std::string plaintext, int textLen, std::string key, int keyLen)
{
    CBC_Mode< AES >::Encryption encctx;
    encctx.SetKeyWithIV((byte*)key.c_str(), keyLen, (byte*)key.c_str());
    
    std::string ciphertext;
    StringSource(plaintext, true,
                 new StreamTransformationFilter(encctx,
                                                new HexEncoder(new StringSink(ciphertext)),
                                                BlockPaddingSchemeDef::PKCS_PADDING)
                 );
    return ciphertext;
}

std::string CryptoUtil::decryptAES256(std::string ciphertext, int textLen, std::string key, int keyLen)
{
    CBC_Mode< AES >::Decryption decctx;
    decctx.SetKeyWithIV((byte*)key.c_str(), keyLen, (byte*)key.c_str());
    
    std::string plaintext;
    std::string encodeHexed;
    StringSource(ciphertext, true,
                 new HexDecoder(new StringSink(encodeHexed))
                 );
    StringSource(encodeHexed, true,
                 new StreamTransformationFilter(decctx,
                                                new StringSink(plaintext),
                                                BlockPaddingSchemeDef::PKCS_PADDING)
                 );
    return plaintext;
}

std::string CryptoUtil::encodeBase64(std::string plaintext)
{
    std::string ciphertext;
    StringSink* sink = new StringSink(ciphertext);
    Base64Encoder *base64Enc = new Base64Encoder(sink);
    StringSource source(plaintext, true, base64Enc);
    
    size_t iPos=-1;
    iPos = ciphertext.find("\n", 0);
    while(iPos>=0)
    {
        ciphertext = ciphertext.erase(iPos, 1);
        iPos = ciphertext.find("\n", 0);
    }
    
    return ciphertext;
}

std::string CryptoUtil::decodeBase64(std::string ciphertext)
{
    std::string plaintext;
    StringSink* sink = new StringSink(plaintext);
    Base64Decoder *base64Enc = new Base64Decoder(sink);
    StringSource dst(ciphertext, true, base64Enc);
    
    return plaintext;
}

std::string CryptoUtil::md5(std::string plaintext)
{
    std::string digest;
    Weak1::MD5 md5;
    StringSource(plaintext, true, new HashFilter(md5, new HexEncoder(new StringSink(digest))));
    return digest;
}

std::string CryptoUtil::md5File(std::string filePath)
{
    std::string digest;
    Weak1::MD5 md5;
    FileSource(filePath.c_str(), true, new HashFilter(md5,new HexEncoder(new StringSink(digest))));
    return digest;
}



