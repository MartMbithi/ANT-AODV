#ifndef __antnet_traffic_h__
#define __antnet_traffic_h__

#include <trace.h>
#include <map>
#include <string>
#include <vector>
#include <classifier-port.h>
#include <random.h>

typedef std::vector<double> triptime_t;
typedef std::map<nsaddr_t, triptime_t> window_t;

struct traffic_matrix {
	double mean_tt;
	double var_tt;
	double best_tt;
};
typedef std::map<nsaddr_t, struct traffic_matrix> state_t;

#endif
