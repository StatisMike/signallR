#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include "signals.h"
#include "base_handlers.h"

// R_CallMethodDef quick reminder:
// {<name of function>, (DL_FUNC) &<name of function>, <number of arguments>}

static const R_CallMethodDef callMethods[] = {

  {"R_getValidSigrts",         (DL_FUNC) &R_getValidSigrts,         0},
  {"R_sendSigrt",              (DL_FUNC) &R_sendSigrt,              2},
  {"R_reg_listener_base1",     (DL_FUNC) &R_reg_listener_base1,     1},
  {"R_reg_listener_base2",     (DL_FUNC) &R_reg_listener_base2,     1},
  {"R_reg_listener_base3",     (DL_FUNC) &R_reg_listener_base3,     1},
  {"R_reg_listener_base4",     (DL_FUNC) &R_reg_listener_base4,     1},
  {"R_reg_listener_base5",     (DL_FUNC) &R_reg_listener_base5,     1},
  {"R_sig_checker_base1",      (DL_FUNC) &R_sig_checker_base1,      1},
  {"R_sig_checker_base2",      (DL_FUNC) &R_sig_checker_base2,      1},
  {"R_sig_checker_base3",      (DL_FUNC) &R_sig_checker_base3,      1},
  {"R_sig_checker_base4",      (DL_FUNC) &R_sig_checker_base4,      1},
  {"R_sig_checker_base5",      (DL_FUNC) &R_sig_checker_base5,      1},
  {NULL, NULL, 0}};


void attribute_visible R_init_signallR(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(info, FALSE);
  R_forceSymbols(info, TRUE);
}
