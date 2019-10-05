//
// Created by fifthdimension on 2019-10-04.
//

#include <stdint.h>

extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}