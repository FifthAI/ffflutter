cmake_minimum_required(VERSION 3.4.1)  # for example

set(distribution_DIR ../../../../libs)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_library(native_ffmpeg SHARED
             ./src/native/export.cpp)

# 使用系统ndk 提供的库，如 log库
# log-lib 这个指定的是在NDK库中每个类型的库会存放一个特定的位置，而log库存放
# 在log-lib中
# log 指定使用log库
find_library(
        log-lib
        log
)
#----------------------ffmpeg的库文件------------
# 加载头文件
include_directories(src/include)

message(${ANDROID_ABI})
message(${CMAKE_SOURCE_DIR})

# 加载avcodec库
# /Users/fd/Projects/fifthai/github/mobile-ffmpeg/prebuilt/android-arm/ffmpeg/lib/libavcodec.so
add_library(avcodec SHARED IMPORTED)
set_target_properties(avcodec
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libavcodec.so)


add_library( avdevice
        SHARED
        IMPORTED)
set_target_properties( avdevice
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libavdevice.so)

add_library( avfilter
        SHARED
        IMPORTED)
set_target_properties( avfilter
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libavfilter.so)

add_library( avformat
        SHARED
        IMPORTED)
set_target_properties( avformat
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libavformat.so)

add_library( avutil
        SHARED
        IMPORTED)
set_target_properties( avutil
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libavutil.so)

add_library( swresample
        SHARED
        IMPORTED)
set_target_properties( swresample
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libswresample.so)

add_library( swscale
        SHARED
        IMPORTED)
set_target_properties( swscale
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../example/android/ffflutter/src/main/jniLibs/${ANDROID_ABI}/libswscale.so)

#----------------------end-----------------------

# 如果你本地的库（native-lib）想要调用log库的方法，
# 那么就需要配置这个属性，意思是把NDK库关联到本地库。
# 第一个参数表示本地的库 native-lib 要调用到log库的方法，即要被关联的库名称，log-lib 要关联的库名称
target_link_libraries(
        native_ffmpeg
        #ffmpeg------start----------
        avcodec
        avdevice
        avfilter
        avformat
        avutil
        swresample
        swscale
        #ffmpeg------end------------
        ${log-lib}
)