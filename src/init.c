#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include "signals.h"

// R_CallMethodDef quick reminder:
// {<name of function>, (DL_FUNC) &<name of function>, <number of arguments>}

static const R_CallMethodDef callMethods[] = {
  // Core module

  // Window-related functions
  {"R_getValidSigrts",         (DL_FUNC) &R_getValidSigrts,         0},
  {"R_setupSIGRTflag",         (DL_FUNC) &R_setupSIGRTflag,         1},
  {"R_checkSIGRTflag",         (DL_FUNC) &R_checkSIGRTflag,         0},

  {NULL, NULL, 0}};


void attribute_visible R_init_signallR(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(info, FALSE);
  R_forceSymbols(info, TRUE);
}
