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

TARGET_BOOTANIMATION_NAME := horizontal-1024x600

# Harmony Configs
PRODUCT_COPY_FILES += \
    #device/malata/smba_common/prebuilt/ramdisk/init.rc:root/init.rc \
    device/malata/smba_common/prebuilt/ramdisk/init.harmony.usb.rc:root/init.harmony.usb.rc \
    device/malata/smba_common/prebuilt/ramdisk/ueventd.harmony.rc:root/ueventd.harmony.rc \
    device/malata/smba_common/prebuilt/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
	device/malata/smba_common/prebuilt/compcache:system/bin/compcache \
    device/malata/smba_common/prebuilt/nvram.txt:system/etc/wifi/nvram.txt

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_UTC_DATE=0 \
    wifi.interface=wlan0 \
	ro.zram.default=18 \
    wifi.supplicant_scan_interval=180 \
    ro.opengles.surface.rgb565=true \
    debug.hwui.render_dirty_regions=false \
    # GPU producer to CPU consumer not supported
    ro.bq.gpu_to_cpu_unsupported=1 \
    ro.zygote.disable_gl_preload=true \
    # Render UI with GPU
    debug.sf.hw=1 \
    # Fuse storage
    persist.fuse_sdcard=true
	
# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# HAL
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.primary.harmony \
    audio.usb.default \
    libaudioutils \
    gps.tegra \
    lights.tegra \
    camera.tegra \
    sensors.tegra

# HW Composer proxy
#PRODUCT_PACKAGES += \
#    hwcomposer.tegra
	
# Media
PRODUCT_COPY_FILES += \
    device/malata/smba_common/prebuilt/media_profiles.xml:system/etc/media_profiles.xml \
    device/malata/smba_common/prebuilt/media_codecs.xml:system/etc/media_codecs.xml \
    device/malata/smba_common/prebuilt/audio_policy.conf:system/etc/audio_policy.conf
	
# These are the hardware-specific feature permissions this was commented out
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
        frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml 

# Bluetooth
PRODUCT_COPY_FILES += \
	device/malata/smba_common/prebuilt/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
	device/malata/smba_common/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf
	
# Touchscreen
PRODUCT_COPY_FILES += \
    device/malata/smba_common/prebuilt/at168_touch.idc:system/usr/idc/at168_touch.idc
	
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	com.android.future.usb.accessory \
	libnetcmdiface \
	libemoji
  
# Filesystem management tools
PRODUCT_PACKAGES += \
	librs_jni \
	setup_fs \
	make_ext4fs \
	l2ping \
	hcitool \
	bttest

DEVICE_PACKAGE_OVERLAYS += device/malata/smba_common/overlay

# for bugmailer
ifneq ($(TARGET_BUILD_VARIANT),user)
	PRODUCT_PACKAGES += send_bug
	PRODUCT_COPY_FILES += \
		system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
		system/extras/bugmailer/send_bug:system/bin/send_bug
endif

# prefer mdpi drawables where available
PRODUCT_AAPT_CONFIG := normal mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

WIFI_BAND := 802_11_ABG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
