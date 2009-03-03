LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)


GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= \
	 gst-inspect.c       
         
        	
LOCAL_SHARED_LIBRARIES := \
        libgstreamer-0.10       \
        libglib-2.0             \
        libgthread-2.0          \
        libgmodule-2.0          \
        libgobject-2.0

LOCAL_MODULE:= gst-inspect-$(GST_MAJORMINOR)

LOCAL_TOP_PATH := $(LOCAL_PATH)/../..

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)           \
    $(LOCAL_PATH)/..       \
    $(LOCAL_TOP_PATH)/gstreamer/android \
    $(LOCAL_TOP_PATH)/gstreamer/gst/android \
    $(LOCAL_TOP_PATH)/gstreamer/gst \
    $(LOCAL_TOP_PATH)/gstreamer/libs \
    $(LOCAL_TOP_PATH)/glib          \
    $(LOCAL_TOP_PATH)/glib/android  \
    $(LOCAL_TOP_PATH)/glib/glib     \
    $(LOCAL_TOP_PATH)/glib/gmodule  \
    $(LOCAL_TOP_PATH)/glib/gobject  \
    $(LOCAL_TOP_PATH)/glib/thread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_EXECUTABLE)
