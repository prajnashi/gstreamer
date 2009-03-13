LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

GST_INDEX_SRC:= 	\
    gstindex.c		\
    gstindexfactory.c

GST_TRACE_SRC:= \
    gsttrace.c

GST_URI_SRC:= \
    gsturi.c

GST_REGISTRY_SRC:= \
    gstregistrybinary.c

GST_LOADSAVE_SRC:=

GST_MAJORMINOR:= 0.10

LOCAL_SRC_FILES:= 			\
    gst.c            			\
    gstobject.c        			\
    gstbin.c        			\
    gstbuffer.c        			\
    gstbus.c        			\
    gstcaps.c        			\
    gstchildproxy.c        		\
    gstclock.c        			\
    gstdebugutils.c        		\
    gstelement.c        		\
    gstelementfactory.c    		\
    gsterror.c        			\
    gstevent.c        			\
    gstfilter.c        			\
    gstformat.c        			\
    gstghostpad.c        		\
    $(GST_INDEX_SRC)    		\
    gstinfo.c        			\
    gstinterface.c        		\
    gstiterator.c        		\
    gstmessage.c        		\
    gstminiobject.c        		\
    gstpad.c        			\
    gstpadtemplate.c    		\
    gstparamspecs.c        		\
    gstpipeline.c        		\
    gstplugin.c        			\
    gstpluginfeature.c    		\
    gstpoll.c        			\
    gstpreset.c          		\
    gstquark.c        			\
    gstquery.c        			\
    gstregistry.c        		\
    gstsegment.c        		\
    gststructure.c        		\
    gstsystemclock.c    		\
    gsttaglist.c        		\
    gsttagsetter.c        		\
    gsttask.c        			\
    $(GST_TRACE_SRC)    		\
    gsttypefind.c        		\
    gsttypefindfactory.c    		\
    $(GST_URI_SRC)        		\
    gstutils.c        			\
    gstvalue.c        			\
    gstparse.c        			\
    $(GST_REGISTRY_SRC)    		\
    $(GST_LOADSAVE_SRC)     		\
    ./android/gst/gstenumtypes.c        \
    ./android/gst/gstmarshal.c          \
    ./android/gst/parse/grammar.tab.c   \
    ./android/gst/parse/lex._gst_parse_yy.c

LOCAL_SHARED_LIBRARIES := 	\
    libglib-2.0             	\
    libgthread-2.0          	\
    libgmodule-2.0          	\
    libgobject-2.0

LOCAL_MODULE:= libgstreamer-$(GST_MAJORMINOR)

LOCAL_C_INCLUDES := 				\
	$(LOCAL_PATH)           		\
	$(GSTREAMER_TOP)			\
	$(GSTREAMER_TOP)/android       		\
	$(LOCAL_PATH)/android   		\
	$(LOCAL_PATH)/android/gst   		\
	$(LOCAL_PATH)/android/gst/parse   	\
	$(LOCAL_PATH)/parse           		\
	external/glib				\
	external/glib/android			\
	external/glib/glib			\
	external/glib/gmodule			\
	external/glib/gobject			\
	external/glib/gthread

LOCAL_CFLAGS := \
    -D_GNU_SOURCE                                   \
    -DG_LOG_DOMAIN=g_log_domain_gstreamer         \
    -DGST_MAJORMINOR=\""$(GST_MAJORMINOR)"\"     \
    -DGST_DISABLE_DEPRECATED                        \
    -DHAVE_CONFIG_H            

include $(BUILD_SHARED_LIBRARY)
