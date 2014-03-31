#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
USE_CAMERA_STUB := false

TARGET_SPECIFIC_HEADER_PATH := device/malata/smba_common/include

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

#arhitecture
TARGET_ARCH := arm
TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := t20
TARGET_BOOTLOADER_BOARD_NAME := harmony
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a
TARGET_ARCH_VARIANT_CPU := cortex-a9
TARGET_ARCH_VARIANT_FPU := vfpv3-d16
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := generic

BOARD_SMBA := true

# Compiler Optimization - This is a @codefireX specific flag to use -O3 everywhere.
ARCH_ARM_HIGH_OPTIMIZATION := true
# ANDROID, LINUX-ARM AND TLS REGISTER EMULATION
ARCH_ARM_HAVE_TLS_REGISTER := true
# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true
#define to use all of the Linaro Cortex-A9 optimized string funcs,
#instead of subset known to work on all machines
USE_ALL_OPTIMIZED_STRING_FUNCS := true
# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16
TARGET_EXTRA_CFLAGS := $(call cc-option,-mtune=cortex-a9) $(call cc-option,-mcpu=cortex-a9)

PRODUCT_CHARACTERISTICS := tablet
BOARD_USE_SKIA_LCDTEXT := true
SMALLER_FONT_FOOTPRINT := true
BOARD_NO_ALLOW_DEQUEUE_CURRENT_BUFFER := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

#platform
TARGET_NO_RADIOIMAGE := true
BOARD_EGL_NEEDS_LEGACY_FB := true

#audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_AUDIO_LEGACY := false
BOARD_USES_ALSA_AUDIO := false
BOARD_OMX_NEEDS_LEGACY_AUDIO := true
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true

BOARD_USES_GENERIC_INVENSENSE := false

#bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/malata/smba_common/bluetooth/libbt_vndcfg.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/malata/smba_common/bluetooth

#graphics
BOARD_EGL_CFG := device/malata/smba_common/prebuilt/egl.cfg
BOARD_USES_OVERLAY := true
USE_OPENGL_RENDERER := true
BOARD_USES_HGL := true
BOARD_USE_MHEAP_SCREENSHOT := true
BOARD_EGL_SKIP_FIRST_DEQUEUE := true
BOARD_USES_HWCOMPOSER := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true
SKIP_SET_METADATA := true

# Enable WEBGL in WebKit
ENABLE_WEBGL := true

# Sensors
TARGET_USES_OLD_LIBSENSORS_HAL := false

# Compatibility with pre-kitkat Sensor HALs
SENSORS_NEED_SETRATE_ON_ENABLE := true

# Misc flags
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/system/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/system/vendor/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP      := "/system/vendor/firmware/fw_bcmdhd_apsta.bin"

# Wi-Fi AP
BOARD_LEGACY_NL80211_STA_EVENTS := true
BOARD_NO_APSME_ATTR := true
 
BOARD_KERNEL_BASE := 0x10000000
BOARD_PAGE_SIZE := 0x00000800
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x01000000

BOARD_USES_SECURE_SERVICES := true

TARGET_OTA_ASSERT_SKIP := true

# Override healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libhealthd.harmony

# SELinux policies
HAVE_SELINUX := true

ifeq ($(HAVE_SELINUX),true)

	#POLICYVERS := 24

	BOARD_SEPOLICY_DIRS += \
	device/notionink/adam_common/sepolicy
 
BOARD_SEPOLICY_UNION := \
    file_contexts \
    app.te \
    device.te \
    drmserver.te \
    file.te \
    genfs_contexts \
    healthd.te \
    init.te \
    media_app.te \
    release_app.te \
    mediaserver.te \
    platform_app.te \
    sensors_config.te \
    shared_app.te \
    surfaceflinger.te \
    system_app.te \
    system.te \
    untrusted_app.te \
    vold.te \
    wpa_socket.te \
    wpa.te \
    zygote.te

endif
