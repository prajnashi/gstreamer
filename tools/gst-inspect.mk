LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= \
	 gst-inspect.c       

LOCAL_SHARED_LIBRARIES := \
        libgstreamer-0.10       \
        libglib-2.0             \
	libgstcontroller-0.10	\
        libgthread-2.0          \
        libgmodule-2.0          \
        libgobject-2.0

LOCAL_MODULE:= gst-inspect-$(GST_MAJORMINOR)

LOCAL_C_INCLUDES := 			\
    $(LOCAL_PATH)           		\
    $(GSTREAMER_TOP)       		\
    $(GSTREAMER_TOP)/gst-libs		\
    external/gstreamer/android 		\
    external/gstreamer/gst/android 	\
    external/gstreamer/gst 		\
    external/gstreamer/libs 		\
    external/glib          		\
    external/glib/android  		\
    external/glib/glib     		\
    external/glib/gmodule  		\
    external/glib/gobject  		\
    external/glib/thread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_EXECUTABLE)
