#include <R.h>
#include <Rinternals.h>
#include <signal.h>

// Create precompiled flags
static volatile sig_atomic_t SIGRT_base1_flag = 0;
static volatile sig_atomic_t SIGRT_base2_flag = 0;
static volatile sig_atomic_t SIGRT_base3_flag = 0;
static volatile sig_atomic_t SIGRT_base4_flag = 0;
static volatile sig_atomic_t SIGRT_base5_flag = 0;

// Create precompiled handlers
void SIGRT_base1_handler (int signum) {
  SIGRT_base1_flag++;
}
void SIGRT_base2_handler (int signum) {
  SIGRT_base2_flag++;
}
void SIGRT_base3_handler (int signum) {
  SIGRT_base3_flag++;
}
void SIGRT_base4_handler (int signum) {
  SIGRT_base4_flag++;
}
void SIGRT_base5_handler (int signum) {
  SIGRT_base5_flag++;
}

// Create precompiled sigactions
SEXP R_reg_listener_base1 (SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action_base1;
  memset(&action_base1, 0, sizeof(action_base1));
  action_base1.sa_handler = SIGRT_base1_handler;
  sigaction(signum, &action_base1, NULL);

  return R_NilValue;

}

SEXP R_reg_listener_base2 (SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action_base2;
  memset(&action_base2, 0, sizeof(action_base2));
  action_base2.sa_handler = SIGRT_base2_handler;
  sigaction(signum, &action_base2, NULL);

  return R_NilValue;

}

SEXP R_reg_listener_base3 (SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action_base3;
  memset(&action_base3, 0, sizeof(action_base3));
  action_base3.sa_handler = SIGRT_base3_handler;
  sigaction(signum, &action_base3, NULL);

  return R_NilValue;

}

SEXP R_reg_listener_base4 (SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action_base4;
  memset(&action_base4, 0, sizeof(action_base4));
  action_base4.sa_handler = SIGRT_base4_handler;
  sigaction(signum, &action_base4, NULL);

  return R_NilValue;

}

SEXP R_reg_listener_base5 (SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action_base5;
  memset(&action_base5, 0, sizeof(action_base5));
  action_base5.sa_handler = SIGRT_base5_handler;
  sigaction(signum, &action_base5, NULL);

  return R_NilValue;

}

// Create precompiled checkers
SEXP R_sig_checker_base1 (SEXP r_refresh) {

  int refresh = Rf_asInteger(r_refresh);
  int out = SIGRT_base1_flag;

  if (refresh == 1)
    SIGRT_base1_flag = 0;

  return Rf_ScalarInteger(out);
}

SEXP R_sig_checker_base2 (SEXP r_refresh) {

  int refresh = Rf_asInteger(r_refresh);
  int out = SIGRT_base2_flag;

  if (refresh == 1)
    SIGRT_base2_flag = 0;

  return Rf_ScalarInteger(out);
}

SEXP R_sig_checker_base3 (SEXP r_refresh) {

  int refresh = Rf_asInteger(r_refresh);
  int out = SIGRT_base3_flag;

  if (refresh == 1)
    SIGRT_base3_flag = 0;

  return Rf_ScalarInteger(out);
}

SEXP R_sig_checker_base4 (SEXP r_refresh) {

  int refresh = Rf_asInteger(r_refresh);
  int out = SIGRT_base4_flag;

  if (refresh == 1)
    SIGRT_base4_flag = 0;

  return Rf_ScalarInteger(out);
}

SEXP R_sig_checker_base5 (SEXP r_refresh) {

  int refresh = Rf_asInteger(r_refresh);
  int out = SIGRT_base5_flag;

  if (refresh == 1)
    SIGRT_base5_flag = 0;

  return Rf_ScalarInteger(out);
}
