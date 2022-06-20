#ifndef BASE_HANDLERS_H
#define BASE_HANDLERS_H

#include <R.h>
#include <Rinternals.h>
#include <signal.h>

SEXP R_reg_listener_base1 (SEXP r_signum);
SEXP R_reg_listener_base2 (SEXP r_signum);
SEXP R_reg_listener_base3 (SEXP r_signum);
SEXP R_reg_listener_base4 (SEXP r_signum);
SEXP R_reg_listener_base5 (SEXP r_signum);

SEXP R_sig_checker_base1 (SEXP r_refresh);
SEXP R_sig_checker_base2 (SEXP r_refresh);
SEXP R_sig_checker_base3 (SEXP r_refresh);
SEXP R_sig_checker_base4 (SEXP r_refresh);
SEXP R_sig_checker_base5 (SEXP r_refresh);

#endif
