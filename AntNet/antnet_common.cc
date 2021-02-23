
#include "antnet_common.h"

int
get_num_neighbors(nsaddr_t node_addr) {
	int count = 0;
	Node *nd = nd->get_node_by_address(node_addr);
	neighbor_list_node* nb = nd->neighbor_list_;
	while(nb != NULL) {
		count ++;
		nb = nb->next;
	}	
	return count;
}

int
get_queue_length(Node *node1, Node *node2) {
	Tcl& tcl = Tcl::instance();
	// get-drop-queue method implemented in ns-lib.tcl
	tcl.evalf("[Simulator instance] get-drop-queue %d %d", node1->nodeid(), node2->nodeid());
	DropTail *qa = (DropTail*)TclObject::lookup(tcl.result());
	int len = qa->getlength();
	return len;
}
