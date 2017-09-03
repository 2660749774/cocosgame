Cocos2d-x引擎修改点
==================

### 1. 修改`lua_cocos2dx_studio_auto.cpp`

移除`setLastFrameCallFunc`的导出

### 2. 修改`lua_cocos2dx_coco_studio_manual.cpp`

增加`setLastFrameCallFunc`的导出

### 3. 移除`CC_CODE_IDE_DEBUG_SUPPORT`支持

- 移除所有对`CodeIDESupport.h`文件的依赖

### 4. 支持新老音效库的切换

### 5. 修改`CCFileUtils.cpp`

- 支持MD5文件路径


