#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include "signals.h"
#include "basehandlers.h"

// R_CallMethodDef quick reminder:
// {<name of function>, (DL_FUNC) &<name of function>, <number of arguments>}

static const R_CallMethodDef callMethods[] = {

  {"R_getValidSigrts",         (DL_FUNC) &R_getValidSigrts,         0},
  {"R_sendSigrt",              (DL_FUNC) &R_sendSigrt,              2},
  {"R_regListener1Base",       (DL_FUNC) &R_regListener1Base,     1},
  {"R_regListener2Base",       (DL_FUNC) &R_regListener2Base,     1},
  {"R_regListener3Base",       (DL_FUNC) &R_regListener3Base,     1},
  {"R_regListener4Base",       (DL_FUNC) &R_regListener4Base,     1},
  {"R_regListener5Base",       (DL_FUNC) &R_regListener5Base,     1},
  {"R_sigChecker1Base",        (DL_FUNC) &R_sigChecker1Base,      1},
  {"R_sigChecker2Base",        (DL_FUNC) &R_sigChecker2Base,      1},
  {"R_sigChecker3Base",        (DL_FUNC) &R_sigChecker3Base,      1},
  {"R_sigChecker4Base",        (DL_FUNC) &R_sigChecker4Base,      1},
  {"R_sigChecker5Base",        (DL_FUNC) &R_sigChecker5Base,      1},
  {NULL, NULL, 0}};


void attribute_visible R_init_signallR(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(info, FALSE);
  R_forceSymbols(info, TRUE);
}
