/* GStreamer
 * Copyright (C) <2005> Thomas Vander Stichele <thomas at apestaart dot org>
 *
 * gststructure.c: Unit tests for GstStructure
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */


#include "../gstcheck.h"


START_TEST (test_from_string_int)
{
  const char *strings[] = {
    "video/x-raw-rgb, width = (int) 123456",
    "video/x-raw-rgb, stride = (int) -123456",
    "video/x-raw-rgb, red_mask = (int) 0xFFFF",
    "video/x-raw-rgb, red_mask = (int) 0x0000FFFF",
    "video/x-raw-rgb, red_mask = (int) 0x7FFFFFFF",
    "video/x-raw-rgb, red_mask = (int) 0x80000000",
    "video/x-raw-rgb, red_mask = (int) 0xFF000000",
  };
  gint results[] = {
    123456,
    -123456,
    0xFFFF,
    0xFFFF,
    0x7FFFFFFF,
    0x80000000,
    0xFF000000,
  };
  GstStructure *structure;
  int i;

  for (i = 0; i < G_N_ELEMENTS (strings); ++i) {
    const char *s;
    const gchar *name;
    gint value;

    s = strings[i];

    structure = gst_structure_from_string (s, NULL);
    fail_if (structure == NULL, "Could not get structure from string %s", s);
    name = gst_structure_nth_field_name (structure, 0);
    fail_unless (gst_structure_get_int (structure, name, &value));
    fail_unless (value == results[i],
        "Value %d is not the expected result %d for string %s",
        value, results[i], s);
  }
}

END_TEST;

Suite *
gst_value_suite (void)
{
  Suite *s = suite_create ("GstStructure");
  TCase *tc_chain = tcase_create ("general");

  suite_add_tcase (s, tc_chain);
  tcase_add_test (tc_chain, test_from_string_int);
  return s;
}

int
main (int argc, char **argv)
{
  int nf;

  Suite *s = gst_value_suite ();
  SRunner *sr = srunner_create (s);

  gst_check_init (&argc, &argv);

  srunner_run_all (sr, CK_NORMAL);
  nf = srunner_ntests_failed (sr);
  srunner_free (sr);

  return nf;
}