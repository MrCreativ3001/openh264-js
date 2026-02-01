#include "../openh264/codec/common/inc/WelsThreadLib.h"

WELS_THREAD_ERROR_CODE sem_timedwait(WELS_EVENT sem,
                                     const struct timespec *abs_timeout) {
  return WELS_THREAD_ERROR_OK;
}