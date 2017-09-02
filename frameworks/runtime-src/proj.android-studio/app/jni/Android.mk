LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

$(call import-add-path,$(LOCAL_PATH)/../../../../cocos2d-x)
$(call import-add-path,$(LOCAL_PATH)/../../../../cocos2d-x/external)
$(call import-add-path,$(LOCAL_PATH)/../../../../cocos2d-x/cocos)

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

# 遍历目录及子目录的函数
define walk
	$(wildcard $(1)) $(foreach e, $(wildcard $(1)/*), $(call walk, $(e)))  
endef

# 遍历Classes目录
ALLFILES = $(call walk, $(LOCAL_PATH)/../../../Classes)

SRC_FILES := hellolua/main.cpp
SRC_FILES += $(filter %.cpp, $(ALLFILES))
SRC_FILES += $(filter %.c, $(ALLFILES))
# SRC_FILES += $(wildcard $(LOCAL_PATH)/../../../Classes/*.cpp)
# SRC_FILES += $(wildcard $(LOCAL_PATH)/../../../Classes/*/*.cpp)
# SRC_FILES += $(wildcard $(LOCAL_PATH)/../../../Classes/*/*.c)
# SRC_FILES += $(wildcard $(LOCAL_PATH)/../../../Classes/*/*/*.c)
SRC_FILES += $(wildcard $(LOCAL_PATH)/../../../../cocos2d-x/tools/simulator/libsimulator/lib/network/*.cpp)
LOCAL_SRC_FILES :=  $(SRC_FILES:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Classes
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../cocos2d-x/external/curl/include/android
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../cocos2d-x/tools/simulator/libsimulator/lib

# _COCOS_HEADER_ANDROID_BEGIN
# _COCOS_HEADER_ANDROID_END

LOCAL_STATIC_LIBRARIES := cocos_curl_static
LOCAL_STATIC_LIBRARIES += cocos2d_lua_static
LOCAL_STATIC_LIBRARIES += cocos2dx_static

# LOCAL_STATIC_LIBRARIES += cocos_extension_static
# LOCAL_STATIC_LIBRARIES += cocostudio_static
LOCAL_STATIC_LIBRARIES += cocos2d_simulator_static

# _COCOS_LIB_ANDROID_BEGIN
# _COCOS_LIB_ANDROID_END

include $(BUILD_SHARED_LIBRARY)

$(call import-module,.)
$(call import-module,./curl/prebuilt/android)
$(call import-module,scripting/lua-bindings/proj.android)
$(call import-module,tools/simulator/libsimulator/proj.android)

# _COCOS_LIB_IMPORT_ANDROID_BEGIN
# _COCOS_LIB_IMPORT_ANDROID_END
