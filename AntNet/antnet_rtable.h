
#ifndef __antnet_rtable_h__
#define __antnet_rtable_h__
#include <trace.h>
#include <map>
#include <string>
#include <vector>
#include <classifier-port.h>
#include <random.h>

#include "ant_pkt.h"
#include "antnet_common.h"

struct pheromone {
	nsaddr_t neighbor;	///< address of neighbor node
	double phvalue;		///< pheromone value
};

typedef std::vector<struct pheromone> pheromone_matrix;
typedef std::map<nsaddr_t, pheromone_matrix> rtable_t;
typedef std::vector<nsaddr_t> sameph_t;

class antnet_rtable {
	rtable_t rt_;	///< routing table
	
	RNG *rnum;	///< random number generator
	public:

		/// Constructor
		antnet_rtable() {
			rnum = new RNG((long int)CURRENT_TIME);
		}
		
		void add_entry(nsaddr_t destination, nsaddr_t neighbor, double phvalue);
		void print();
		nsaddr_t calc_destination(nsaddr_t source);
		nsaddr_t calc_next(nsaddr_t source, nsaddr_t destination, nsaddr_t parent);
		void update(nsaddr_t destination, nsaddr_t neighbor);
};

#endif
