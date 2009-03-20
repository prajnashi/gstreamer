LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= 		\
	gstelements.c		\
	gstfilesrc.c		\
	gstqueue.c		\
	gstcapsfilter.c	 	\
	gstfakesrc.c		\
	gstfakesink.c	   	\
	gstfilesink.c	   	\
	gstidentity.c	   	\
	gsttee.c		\
	gsttypefindelement.c	\
	gstmultiqueue.c		\
	gstfdsrc.c		\
	gstfdsink.c

LOCAL_SHARED_LIBRARIES := \
	libgstbase-0.10	   \
	libgstreamer-0.10	 \
	libglib-2.0		   \
	libgthread-2.0		\
	libgmodule-2.0		\
	libgobject-2.0

LOCAL_MODULE:= libgstcoreelements

LOCAL_C_INCLUDES := 			\
	external/gstreamer	   	\
	external/gstreamer/android	\
	external/gstreamer/libs 	\
	external/gstreamer/gst		\
	external/gstreamer/gst/android	\
	external/glib   		\
	external/glib/android   	\
	external/glib/glib   		\
	external/glib/gmodule   	\
	external/glib/gobject  		\
	external/glib/gthread

LOCAL_CFLAGS := \
	-DHAVE_CONFIG_H			

include $(BUILD_PLUGIN_LIBRARY)
