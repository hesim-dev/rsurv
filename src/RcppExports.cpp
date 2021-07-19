// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// C_rsurv
std::vector<double> C_rsurv(std::vector<double>& time, std::vector<double> prob, std::vector<int> n_times, int n_rep);
RcppExport SEXP _rsurv_C_rsurv(SEXP timeSEXP, SEXP probSEXP, SEXP n_timesSEXP, SEXP n_repSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector<double>& >::type time(timeSEXP);
    Rcpp::traits::input_parameter< std::vector<double> >::type prob(probSEXP);
    Rcpp::traits::input_parameter< std::vector<int> >::type n_times(n_timesSEXP);
    Rcpp::traits::input_parameter< int >::type n_rep(n_repSEXP);
    rcpp_result_gen = Rcpp::wrap(C_rsurv(time, prob, n_times, n_rep));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rsurv_C_rsurv", (DL_FUNC) &_rsurv_C_rsurv, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_rsurv(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}