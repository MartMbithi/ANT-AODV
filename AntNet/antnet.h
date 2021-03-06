

#ifndef __antnet_h__
#define __antnet_h__

#include <agent.h>
#include <node.h>
#include <packet.h>
#include <ip.h>
#include <trace.h>
#include <timer-handler.h>
#include <random.h>
#include <classifier-port.h>
#include <tools/rng.h>

#include "trace/cmu-trace.h"
#include "tools/queue-monitor.h"
#include "queue/drop-tail.h"

#include "ant_pkt.h"
#include "antnet_common.h"
#include "antnet_rtable.h"
#include "antnet_traffic.h"

#include <map>
//#include <vector_richardson>
#include <vector>
#include <list>

class Antnet;	// forward declaration


class Ant_timer: public TimerHandler {
	public:
		Ant_timer(Antnet* agent) : TimerHandler() {
			agent_ = agent;
		}
	protected:
		Antnet* agent_;
		virtual void expire(Event* e);
};

class Antnet: public Agent {
	
	friend class Ant_timer;
	
	nsaddr_t ra_addr_;	///< address of the agent
	antnet_rtable rtable_;	///< instance of routing table class
	state_t state_;		///< local traffic model
	window_t window_;	///< window of trip times to all destinations
	u_int8_t ant_seq_num_;	///< sequence number for ant packets
	
	// parameters that can be set from tcl script
	// default values defined in ns-default.tcl
	double r_factor_;	///< reinforcement factors
	double timer_ant_;	///< interval between generation of forward ants
	int num_nodes_;		///< total number ofnodes in topology
	int num_nodes_x_;	///< number of nodes in row (only for regular mesh topology)
	int num_nodes_y_;	///< number of nodes in column (only for regular mesh topology)
	
	protected:
		PortClassifier* dmux_;	///< for passing packets to agent
		Trace* logtarget_;	///< for logging
		Ant_timer ant_timer_;	///< timer for generation of ants
		
		inline nsaddr_t& ra_addr() {return ra_addr_;}
		inline int& num_nodes_x() {return num_nodes_x_;}
		inline int& num_nodes_y() {return num_nodes_y_;}
		inline u_int8_t& ant_seq_num() {return ant_seq_num_;}
		inline state_t& state() {return state_;}
		inline window_t& window() {return window_;}

		void reset_ant_timer();		///< reset ant timer
		void send_ant_pkt();		///< generate forward ant
		void recv_ant_pkt(Packet*);	///< recieve an ant packet
		void create_backward_ant_pkt(Packet*);	///< generate backward ant
		void forward_ant_pkt(Packet*);		///< send a forward ant to next hop as per AntNet algorithm
		void backward_ant_pkt(Packet*);		///< send a backward ant to next hop as per AntNet algorithm
		void memorize(Packet*);		///< add visited node to memory of forward ant
		void update_table(Packet*);	///< update routing table
		void update_traffic(Packet*);	///< update traffic model
		
		/// print neighbors of a node
		// implemented to test and debug
		void print_neighbors();
		/// add two nodes to each other's neighbor list (assuming duplex link)
		void add_Neighbor(Node* node1, Node* node2);
		
		void initialize_rtable();	///< initialize routing table
		int get_win_size(nsaddr_t dest);///< return size of observation window
		
	public:
		Antnet(nsaddr_t);	///< Constructor
		int command(int , const char*const*);	///< interface for tcl commands
		void recv(Packet*, Handler*);		///< method to handle packet recieve events at the Agent
};

#endif

