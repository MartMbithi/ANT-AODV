
#ifndef __ant_pkt_h__
#define __ant_pkt_h__

#include <packet.h>
#include <list>
#include "antnet_common.h"

#define FORWARD_ANT 0x01
/// Backward ant identifier
#define BACKWARD_ANT 0x02
/// Size of ant packet
#define ANT_SIZE 7
/// Macro to access ant header
#define HDR_ANT_PKT(p) hdr_ant_pkt::access(p)

struct memory{
	nsaddr_t node_addr;	///< node address
	double trip_time;	///< trip time to node
};


struct hdr_ant_pkt {
        u_int8_t pkt_type_;	
	nsaddr_t pkt_src_;	
	nsaddr_t pkt_dst_;	
	u_int16_t pkt_len_;	
	u_int8_t pkt_seq_num_;	
	double pkt_start_time_;	
	struct memory pkt_memory_[MAX_NUM_NODES];	
	int pkt_mem_size_;	
	
	inline nsaddr_t& pkt_src() {return pkt_src_;}
	inline nsaddr_t& pkt_dst() {return pkt_dst_;}
	inline u_int16_t& pkt_len() {return pkt_len_;}
	inline u_int8_t& pkt_seq_num() {return pkt_seq_num_;}
	inline double& pkt_start_time() {return pkt_start_time_;}
	inline int& pkt_mem_size() {return pkt_mem_size_;}
	inline u_int8_t& pkt_type() {return pkt_type_;}
		
	static int offset_;
	inline static int& offset() {return offset_;}
	
	inline static hdr_ant_pkt* access(const Packet *p) {
		return (hdr_ant_pkt*)p->access(offset_);
	}
};

#endif
