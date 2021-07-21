#include <Rcpp.h>
using namespace Rcpp;

int rbernoulli(double p){
  return R::runif(0, 1) > (1 - p);
}

/***************************************************************************//** 
 * Random number generation from an arbitrary survival distribution.
 * Randomly draw a single observation from survival curves.
 * @param time_start,time_end Iterators pointing to the start and end of a 
 * vector of times at which survival probabilities were computed. 
 * @param prob_start Iterator pointing to the start of a vector of survival
 * probabilities.
 * @return A random draw from the survival distribution.
 ******************************************************************************/ 
double rsurv(std::vector<double>::iterator time_start, 
              std::vector<double>::iterator time_end,
              std::vector<double>::iterator prob_start){
  
  double died = 0;
  std::vector<double>::iterator time_it = time_start + 1;
  std::vector<double>::iterator prob_it = prob_start + 1;

  while(died == 0 && time_it != time_end){
    double prob_i = 1 - *prob_it / *(prob_it - 1);
    died = rbernoulli(prob_i);
    if (died == 1){
      return *time_it;
    } 
    else{
      time_it++;
      prob_it++;
    }
  }
  return INFINITY;
}

// [[Rcpp::export]]
std::vector<double> C_rsurv(std::vector<double> &time, std::vector<double> prob,
                          std::vector<int> n_times, int n_rep) {
  unsigned int n_id = n_times.size();
  std::vector<double> random_times(n_id * n_rep);
  
  int cntr = 0;
  for (int i = 0; i < n_rep; ++i) { // Loop over replications
    int row = 0;
    for (int j = 0; j < n_id; ++j) { // Loop over IDs
      
      random_times[cntr] = rsurv(time.begin() + row, 
                                 time.begin() + row + n_times[j] - 1, 
                                 prob.begin() + row);
      row = row + n_times[j];
      cntr++;
    } // End loop over IDs
  } // End loop over replications

  
  return random_times;
}
