/*
 * gst-controller.h
 * 
 * New dynamic properties
 */

#ifndef __GST_CONTROLLER_H__
#define __GST_CONTROLLER_H__

#include <string.h>

#include <glib.h>
#include <glib-object.h>
#include <glib/gprintf.h>
#include <gst/gst.h>

G_BEGIN_DECLS

/**
 * GST_PARAM_CONTROLLABLE:
 *
 * Use this flag on GstElement properties you wish to be (eventually) handled
 * by a GstController.
 * TODO: needs to go to gstelemnt.h (to avoid clashes on G_PARAM_USER_SHIFT)
 */
#define	GST_PARAM_CONTROLLABLE	(1 << (G_PARAM_USER_SHIFT + 1))


/**
 * GstTimedValue:
 *
 * a structure for value+time
 */
typedef struct _GstTimedValue
{
  GstClockTime timestamp;       // timestamp of the value change
  GValue value;                 // the new value
  /* TODO what about storing the difference to next timestamp and value here
     + make calculations slightly easier and faster
     - determining the GType for the value_dif is not simple
     e.g. if value is G_TYPE_UCHAR value_diff needs to be G_TYPE_INT
   */
} GstTimedValue;


/**
 * GstValueArray:
 *
 * Structure to receive multiple values at once
 */
typedef struct _GstValueArray
{
  gchar *property_name;
  gint nbsamples;               // Number of samples requested
  GstClockTime sample_interval; // Interval between each sample
  gpointer *values;             // pointer to the array (so it can be filled if NULL)
} GstValueArray;


/**
 * GstInterpolateMode:
 * @GST_INTERPOLATE_NONE: steps-like interpolation, default
 * @GST_INTERPOLATE_TRIGGER: returns the default value of the property, 
 * except for times with specific values
 * @GST_INTERPOLATE_LINEAR: linear interpolation
 * @GST_INTERPOLATE_QUADRATIC: square interpolation
 * @GST_INTERPOLATE_CUBIC: cubic interpolation
 * @GST_INTERPOLATE_USER: user-provided interpolation
 *
 * The various interpolation modes available.
 */
typedef enum
{
  GST_INTERPOLATE_NONE,
  GST_INTERPOLATE_TRIGGER,
  GST_INTERPOLATE_LINEAR,
  GST_INTERPOLATE_QUADRATIC,
  GST_INTERPOLATE_CUBIC,
  GST_INTERPOLATE_USER
} GstInterpolateMode;


struct _GstControlledProperty;

typedef GValue *(*InterpolateGet) (struct _GstControlledProperty * prop,
        GstClockTime timestamp);
typedef gboolean (*InterpolateGetValueArray) (struct _GstControlledProperty * prop,
        GstClockTime timestamp, GstValueArray * value_array);

/**
 * GstInterpolateMethod:
 *
 * Function pointer structure to do user-defined interpolation methods
 */
typedef struct _GstInterpolateMethod
{
  InterpolateGet get_int;
  InterpolateGetValueArray get_int_value_array;
  InterpolateGet get_long;
  InterpolateGetValueArray get_long_value_array;
  InterpolateGet get_float;
  InterpolateGetValueArray get_float_value_array;
  InterpolateGet get_double;
  InterpolateGetValueArray get_double_value_array;
} GstInterpolateMethod;

/**
 * GstControlledProperty:
 */
typedef struct _GstControlledProperty
{
  gchar *name;                  // name of the property
  GObject *object;              // the object we control
  GType type;                   // type of the handled property
  GValue default_value;         // default value for the handled property
  GValue result_value;          // result value location for the interpolation method
  GstTimedValue last_value;     // the last value a _sink call wrote
  GstTimedValue live_value;     // temporary value override for live input
  gulong notify_handler_id;     // id of the notify::<name> signal handler
  GstInterpolateMode interpolation;     // Interpolation mode
  /* TODO instead of *method, have pointers to get() and get_value_array() here
     gst_controller_set_interpolation_mode() will pick the right ones for the
     properties value type
     GstInterpolateMethod *method; // User-implemented handler (if interpolation == GST_INTERPOLATE_USER)
  */
  InterpolateGet get;
  InterpolateGetValueArray get_value_array;

  GList *values;                // List of GstTimedValue
  /* TODO keep the last search result to be able to continue
     GList      *last_value;                    // last search result, can be used for incremental searches
   */
} GstControlledProperty;

#define GST_CONTROLLED_PROPERTY(obj)    ((GstControlledProperty *)(obj))

/* type macros */

#define GST_TYPE_CONTROLLER	       (gst_controller_get_type ())
#define GST_CONTROLLER(obj)	       (G_TYPE_CHECK_INSTANCE_CAST ((obj), GST_TYPE_CONTROLLER, GstController))
#define GST_CONTROLLER_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST ((klass), GST_TYPE_CONTROLLER, GstControllerClass))
#define GST_IS_CONTROLLER(obj)	       (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GST_TYPE_CONTROLLER))
#define GST_IS_CONTROLLER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GST_TYPE_CONTROLLERE))
#define GST_CONTROLLER_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS ((obj), GST_TYPE_CONTROLLER, GstControllerClass))

typedef struct _GstController GstController;
typedef struct _GstControllerClass GstControllerClass;

//typedef struct _GstControllerPrivate GstControllerPrivate;

/**
 * GstController:
 *
 * The instance structure of GstController
 */

struct _GstController
{
  GObject parent;

  GList *properties;  // List of GstControlledProperty
  GMutex *lock;       // Secure property access, elements will access from threads
};

struct _GstControllerClass
{
  GObjectClass parent_class;
};

GType gst_controller_get_type (void);

/* GstController functions */

GstController *gst_controller_new_valist (GObject * object, va_list var_args);
GstController *gst_controller_new (GObject * object, ...);

gboolean gst_controller_remove_properties_valist (GstController * self,
    va_list var_args);
gboolean gst_controller_remove_properties (GstController * self, ...);

gboolean gst_controller_set (GstController * self, gchar * property_name,
    GstClockTime timestamp, GValue * value);
gboolean gst_controller_set_from_list (GstController * self,
    gchar * property_name, GSList * timedvalues);

gboolean gst_controller_unset (GstController * self, gchar * property_name,
    GstClockTime timestamp);


GValue *gst_controller_get (GstController * self, gchar * property_name,
    GstClockTime timestamp);
const GList *gst_controller_get_all (GstController * self,
    gchar * property_name);


gboolean gst_controller_sink_values (GstController * self,
    GstClockTime timestamp);
    
gboolean gst_controller_get_value_arrays (GstController * self,
    GstClockTime timestamp, GSList * value_arrays);
gboolean gst_controller_get_value_array (GstController * self,
    GstClockTime timestamp, GstValueArray * value_array);

gboolean gst_controller_set_interpolation_mode (GstController * self,
    gchar * property_name, GstInterpolateMode mode);


/* GObject convenience functions */

GstController *g_object_control_properties (GObject * object, ...);
gboolean g_object_uncontrol_properties (GObject * object, ...);

GstController *g_object_get_controller (GObject * object);
gboolean g_object_set_controller (GObject * object, GstController * controller);

gboolean g_object_sink_values (GObject * object, GstClockTime timestamp);

gboolean g_object_get_value_arrays (GObject * object,
    GstClockTime timestamp, GSList * value_arrays);
gboolean g_object_get_value_array (GObject * object,
    GstClockTime timestamp, GstValueArray * value_array);

/* lib init/done */

gboolean gst_controller_init (int * argc, char ***argv);

G_END_DECLS
#endif /* __GST_CONTROLLER_H__ */