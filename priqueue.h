#ifndef _priqueue_h
#define _priqueue_h

#include "object.h"
#include "queue.h"
#include "drop-tail.h"
#include "packet.h"
#include "lib/bsd-list.h"

class PriQueue;
typedef int (*PacketFilter)(Packet *, void *);

LIST_HEAD(PriQueue_List, PriQueue);

class PriQueue : public DropTail {
public:
        PriQueue();

        int     command(int argc, const char*const* argv);
        void    recv(Packet *p, Handler *h);

        void    recvHighPriority(Packet *, Handler *);
        /* Load Packet in FIFO  */
        void filter(PacketFilter filter, void * data);
        
        Packet* filter(nsaddr_t id);

	void	Terminate(void);
private:
        int Prefer_Routing_Protocols;
 
	/*
	 * A global list of Interface Queues.  I use this list to iterate
	 * over all of the queues at the end of the simulation and flush
	 * their contents. - josh
	 */
public:
	LIST_ENTRY(PriQueue) link;
	static struct PriQueue_List prhead;
};

#endif /* !_priqueue_h */
