LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= \
    lib.c \
    gstcontroller.c \
    gstinterpolation.c \
    gsthelper.c \
    gstcontrolsource.c \
    gstinterpolationcontrolsource.c \
    gstlfocontrolsource.c

LOCAL_SHARED_LIBRARIES := \
    libgstreamer-0.10       \
    libglib-2.0             \
    libgthread-2.0          \
    libgmodule-2.0          \
    libgobject-2.0

LOCAL_MODULE:= libgstcontroller-$(GST_MAJORMINOR)

LOCAL_C_INCLUDES := 			\
	$(GSTREAMER_TOP)		\
	external/gstreamer 		\
	external/gstreamer/android 	\
	external/gstreamer/libs		\
	external/gstreamer/gst		\
	external/gstreamer/gst/android	\
	external/glib			\
	external/glib/android		\
	external/glib/glib		\
	external/glib/gmodule		\
	external/glib/gobject  		\
	external/glib/gthread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_SHARED_LIBRARY)
