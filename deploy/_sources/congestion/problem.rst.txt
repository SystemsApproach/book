Problem: Allocating Resources
-----------------------------

By now we have seen enough layers of the network protocol hierarchy to
understand how data can be transferred among processes across
heterogeneous networks. We now turn to a problem that spans the entire
protocol stack—how to effectively and fairly allocate resources among a
collection of competing users. The resources being shared include the
bandwidth of the links and the buffers on the routers or switches where
packets are queued awaiting transmission. Packets *contend* at a router
for the use of a link, with each contending packet placed in a queue
waiting its turn to be transmitted over the link. When too many packets
are contending for the same link, the queue fills and two undesirable
things happen: packets experience increased end-to-end delay, and in the
worst case, the queue overflows and packets have to be dropped. When
long queues persist and drops become common, the network is said to be
*congested*. Most networks provide a *congestion-control* mechanism to
deal with just such a situation.

Congestion control and resource allocation are two sides of the same
coin. On the one hand, if the network takes an active role in allocating
resources—for example, scheduling which virtual circuit gets to use a
given physical link during a certain period of time—then congestion may
be avoided, thereby making congestion control unnecessary. Allocating
network resources with any precision is difficult, however, because the
resources in question are distributed throughout the network; multiple
links connecting a series of routers need to be scheduled. On the other
hand, you can always let packet sources send as much data as they want
and then recover from congestion should it occur. This is the easier
approach, but it can be disruptive because many packets may be discarded
by the network before congestion can be controlled. Furthermore, it is
precisely at those times when the network is congested—that is,
resources have become scarce relative to demand—that the need for
resource allocation among competing users is most keenly felt. There are
also solutions in the middle, whereby inexact allocation decisions are
made, but congestion can still occur and hence some mechanism is still
needed to recover from it. Whether you call such a mixed solution
congestion control or resource allocation does not really matter. In
some sense, it is both.

Congestion control and resource allocation involve both hosts and
network elements such as routers. In network elements, various queuing
disciplines can be used to control the order in which packets get
transmitted and which packets get dropped. The queuing discipline can
also segregate traffic to keep one user’s packets from unduly affecting
another user’s packets. At the end hosts, the congestion-control
mechanism paces how fast sources are allowed to send packets. This is
done in an effort to keep congestion from occurring in the first place
and, should it occur, to help eliminate the congestion.

This chapter starts with an overview of congestion control and resource
allocation. We then discuss different queuing disciplines that can be
implemented on the routers inside the network, followed by a description
of the congestion-control algorithm provided by TCP on the hosts. The
fourth section explores various techniques involving both routers and
hosts that aim to avoid congestion before it becomes a problem. Finally,
we examine the broad area of *quality of service*. We consider the needs
of applications to receive different levels of resource allocation in
the network and describe a number of ways in which they can request
these resources and the network can meet the requests.
