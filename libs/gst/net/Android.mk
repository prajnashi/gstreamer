LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= \
    gstnetclientclock.c \
    gstnettimepacket.c \
    gstnettimeprovider.c

LOCAL_SHARED_LIBRARIES := \
    libgstreamer-0.10       \
    libglib-2.0             \
    libgthread-2.0          \
    libgmodule-2.0          \
    libgobject-2.0

LOCAL_MODULE:= libgstnet-$(GST_MAJORMINOR)

#LOCAL_TOP_PATH := $(LOCAL_PATH)/../../../..

LOCAL_C_INCLUDES := 			\
    $(GSTREAMER_TOP) 			\
    external/gstreamer       		\
    external/gstreamer/android       	\
    external/gstreamer/gst		\
    external/gstreamer/gst/android	\
    external/glib   			\
    external/glib/android   		\
    external/glib/glib   		\
    external/glib/gmodule   		\
    external/glib/gobject  		\
    external/glib/gthread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_SHARED_LIBRARY)
