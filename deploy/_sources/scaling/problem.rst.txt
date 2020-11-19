Problem: Scaling to Billions
----------------------------

We have now seen how to build an internetwork that consists of a number
of networks of different types. That is, we have dealt with the problem
of *heterogeneity*. The second critical problem in
internetworking—arguably the fundamental problem for all networking—is
*scale*. To understand the problem of scaling a network, it is worth
considering the growth of the Internet, which has roughly doubled in
size each year for 30 years. This sort of growth forces us to face a
number of challenges.

Chief among these is how do you build a routing system that can handle
hundreds of thousands of networks and billions of end nodes? As we will
see in this chapter, most approaches to tackling the scalability of
routing depend on the introduction of hierarchy. We can introduce
hierarchy in the form of areas within a domain; we also use hierarchy to
scale the routing system among domains. The interdomain routing protocol
that has enabled the Internet to scale to its current size is BGP. We
will take a look at how BGP operates, and consider the challenges faced
by BGP as the Internet continues to grow.

Closely related to the scalability of routing is the problem of
addressing. Even two decades ago it had become apparent that the 32-bit
addressing scheme of IP version 4 would not last forever. That led to
the definition of a new version of IP—version 6, since version 5 had
been used in an earlier experiment. IPv6 primarily expands the address
space but also adds a number of new features, some of which have been
retrofitted to IPv4.

While the Internet continues to grow in size, it also needs to evolve
its functionality. The final sections of this chapter cover some
significant enhancements to the Internet’s capabilities. The first,
multicast, is an enhancement of the basic service model. We show how
multicast—the ability to deliver the same packets to a group of
receivers efficiently—can be incorporated into an internet, and we
describe several of the routing protocols that have been developed to
support multicast. The second enhancement, Multiprotocol Label Switching
(MPLS), modifies the forwarding mechanism of IP networks. This
modification has enabled some changes in the way IP routing is performed
and in the services offered by IP networks. Finally, we look at the
effects of mobility on routing and describe some enhancements to IP to
support mobile hosts and routers. For each of these enhancements, issues
of scalability continue to be important.
