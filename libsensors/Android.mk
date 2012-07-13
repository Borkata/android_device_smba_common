# Copyright (C) 2009 Motorola, Inc.
# Copyright (C) 2008 The Android Open Source Project
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

ifneq ($(filter smba9701,$(TARGET_DEVICE)),)

LOCAL_PATH:= $(call my-dir)

# HAL module implemenation stored in
# hw/<COPYPIX_HARDWARE_MODULE_ID>.<ro.board.platform>.so
include $(CLEAR_VARS)

LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\"

LOCAL_SRC_FILES := 						\
				sensors.c 			\
				nusensors.cpp 			\
				InputEventReader.cpp		\
				SensorBase.cpp			\
				AccelerationSensor.cpp		\
				LightSensor.cpp


ifeq ($(BOARD_HAVE_MAGNETIC_SENSOR),true)
LOCAL_SRC_FILES += 						\
				MagneticSensor.cpp
LOCAL_CFLAGS += -DMAGNETIC_SENSOR
endif

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_MODULE_TAGS := optional
LOCAL_SHARED_LIBRARIES := liblog libcutils

LOCAL_MODULE := sensors.tegra

include $(BUILD_SHARED_LIBRARY)

endif