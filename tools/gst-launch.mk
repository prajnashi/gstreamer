LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= \
    gst-launch.c       

LOCAL_SHARED_LIBRARIES := \
    libgstreamer-0.10       \
    libglib-2.0             \
    libgthread-2.0          \
    libgmodule-2.0          \
    libgobject-2.0

LOCAL_MODULE:= gst-launch-$(GST_MAJORMINOR)

#LOCAL_TOP_PATH := $(LOCAL_PATH)/../..

LOCAL_C_INCLUDES := 			\
	$(LOCAL_PATH)   		\
	$(GSTREAMER_TOP)		\
	external/gstreamer/android 	\
	external/gstreamer/gst/android 	\
	external/gstreamer/gst 		\
	external/gstreamer/libs 	\
	external/glib  			\
	external/glib/android  		\
	external/glib/glib 		\
	external/glib/gmodule  		\
	external/glib/gobject  		\
	external/glib/thread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_EXECUTABLE)
