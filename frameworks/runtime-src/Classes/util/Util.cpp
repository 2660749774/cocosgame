//
//  Util.cpp
//  game
//
//  Created by 王愿生 on 2016/12/29.
//
//

#include "Util.h"

using namespace std;

// 获取当前系统时间
int32_t Util::getCurrentTime()
{
    auto now = std::chrono::steady_clock::now();
    return std::chrono::duration_cast<std::chrono::milliseconds>(now.time_since_epoch()).count() & 0x7ffffffful;
}

// 析构函数
Util::~Util(void)
{
}


