# 工程绝对路径
project_path=$(pwd)
# build文件夹路径
build_path=${project_path}/build

# 工程配置文件路径
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
#project_infoplist_path=${project_path}/${project_name}/${project_name}-Info.plist
#取版本号
#bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})
#取build值
#bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${project_infoplist_path})
#取bundle Identifier前缀
#bundlePrefix=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" `find . -name "*-Info.plist"` | awk -F$ '{print $1}')


cd $project_path
# echo clean start ...
# #删除bulid目录
if  [ -d ${build_path}/ipa-build ];then
    rm -rf ${build_path}/ipa-build
    echo clean build_path success.
fi
# 清理工程
# xcodebuild clean || exit
# 去掉xcode源码末尾的空格
# find . -name "*.[hm]" | xargs sed -Ee 's/ +$//g' -i ""

#编译工程
xcodebuild  -configuration Release \
-project ${project_path}/${project_name}.xcodeproj \
-target ${project_name}-mobile \
CONFIGURATION_BUILD_DIR=${project_path}/build/Release-iphoneos

# 打包
cd $build_path
mkdir -p ipa-build/Payload
cp -r ./Release-iphoneos/*.app ./ipa-build/Payload/

# 打包IPA
cd ipa-build
zip -r ${project_name}.ipa *

# 输出产品路径
echo ${build_path}/ipa-build/${project_name}.ipa
#找到桌面路径
# cd ~/Desktop
# #echo Desktop dir
# #echo $(pwd)
# #拷贝文件
# cp -r ${build_path}/ipa-build/${project_name}.ipa  $(pwd)
# #清空bulid目录
# cd ${build_path}/ipa-build
# rm -rf Payload
# if  [ -d ${build_path} ];then
# rm -rf ${build_path}
# fi


#configuration for iOS build setting
# CODE_SIGN_IDENTITY = "iPhone Distribution: Shanghai Game Reign Network Technology Co.LTD"
# PROVISIONING_PROFILE = "gametest"
# CONFIGURATION="Release"
# SDK="iphoneos"
# target=${project_name}-mobile
# output=${project_path}/game.ipa


# xcodebuild -project ${project_path}/${project_name}.xcodeproj \
# -target ${target} \
# -sdk ${SDK} \
# -configuration ${CONFIGURATION} \
# build \
# CONFIGURATION_BUILD_DIR=${project_path}/build/Release-iphoneos
# # CODE_SIGN_IDENTITY=${CODE_SIGN_IDENTITY} \
# # PROVISIONING_PROFILE=${PROVISIONING_PROFILE}


# # signApp = ${build_path}/${CONFIGURATION}-iphoneos/${target}.app
# xcrun -sdk ${SDK} -v PackageApplication ${project_path}/build/Release-iphoneos/${target}.app -o ${output}

