/*
  Set any config.h overrides for your specific keymap here.
  See config.h options at https://docs.qmk.fm/#/config_options?id=the-configh-file
*/

#undef RGB_MATRIX_HUE_STEP
#define RGB_MATRIX_HUE_STEP 1

#undef RGB_MATRIX_TIMEOUT
#define RGB_MATRIX_TIMEOUT 180000

#undef RGB_MATRIX_VAL_STEP
#define RGB_MATRIX_VAL_STEP 1

#define USB_SUSPEND_WAKEUP_DELAY 0
#define SERIAL_NUMBER "pzKDR/3ewAw"
#define LAYER_STATE_16BIT
#define HSS(report) host_system_send(record->event.pressed ? report : 0); return false
#define HCS(report) host_consumer_send(record->event.pressed ? report : 0); return false

#define RGB_MATRIX_STARTUP_SPD 60

