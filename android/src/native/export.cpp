//
// Created by fifthdimension on 2019-10-05.
//
#include <stdint.h>

extern "C" {
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
}

extern "C"  __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    printf("avcodec_version %d",avcodec_version());
    return avcodec_version();
}

