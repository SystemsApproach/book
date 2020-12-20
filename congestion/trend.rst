Perspective: Software-Defined Traffic Engineering
=================================================

The overarching problem this chapter addresses is how to allocate the
available network bandwidth to a set of end-to-end flows. Whether it’s
TCP congestion control, integrated services, or differentiated services,
there is an assumption that the underlying network bandwidth being
allocated is fixed: a 1-Gbps link between site A and site B is always a
1-Gbps link, and the algorithms focus on how to best share that 1-Gbps
among competing users. But what if that’s not the case? What if you
could “instantly” acquire additional capacity, so the 1-Gbps link is
upgraded to a 10-Gbps link, or perhaps you could add a new link between
two sites that had not previously been connected?

This possibility is real, and it’s a topic that’s usually referred to as
*traffic engineering*, a term that dates back to the early days of
networking when operators would analyze the traffic workloads on their
network, and periodically re-engineer their networks to add capacity
when the existing links became chronically overloaded. In those early
days, the decision to add capacity was not taken lightly; you needed to
be sure the usage trend you observed was not just a passing blip since
it would take a significant amount of time and money to change the
network. In the worse case, it might involve laying cable across an
ocean or launching a satellite into space.

But with the advent of technologies like DWDM (:ref:`Section 3.1
<3.1 Switching Basics>`) and MPLS (:ref:`Section 4.4 <4.4
Multiprotocol Label Switching>`), we don’t always have to lay more fiber,
but can instead turn on additional wavelengths or establish new circuits
between any pair of sites. (These sites need not be directly connected
by fiber. For example, a wavelength between Boston and San Francisco
might run through ROADMs in Chicago and Denver, but from the perspective
of the L2/L3 network topology, Boston and San Francisco are connected by
a direct link.) This dramatically lowers the time-to-availability, but
reconfiguring hardware still requires manual intervention, and so our
definition of “instantly” is still measured in days, if not weeks.
Afterall, there are requisition forms to be filled out, in triplicate!

But as we have seen again and again, once you provide the right
programmatic interfaces, software can be brought to bear on the problem,
and “instantly” can, for all practical purposes, be truly instantaneous.
This is effectively what cloud providers do with the private backbones
they build to interconnect their datacenters. For example, Google has
publicly described their private WAN, called B4, which is built entirely
using white-box switches and SDN. B4 does not add/drop wavelengths to
adjust inter-node bandwidth—it dynamically builds end-to-end tunnels
using a technique called *Equal-Cost Multipath* (ECMP), an alternative
to CSPF introduced in :ref:`Section 4.4 <4.4 Multiprotocol Label
Switching>`\ —but the flexibility it affords is similar.

A Traffic Engineering (TE) control program then provisions the network
according to the needs of various classes of applications. B4 identifies
three such classes: (1) copying user data (e.g., email, documents,
audio/video) to remote datacenters for availability; (2) accessing
remote storage by computations that run over distributed data sources;
and (3) pushing large-scale data to synchronize state across multiple
datacenters. These classes are ordered in increasing volume, decreasing
latency sensitivity, and decreasing overall priority. For example,
user-data represents the lowest volume on B4, is the most latency
sensitive, and is of the highest priority.

By centralizing the decision-making process, which is one of the claimed
advantages of SDN, Google has been able to drive their link utilizations
to near 100%. This is two to three times better than the 30-40% average
utilization that WAN links are typically provisioned for, which is
necessary to allow those networks to deal with both traffic bursts and
link/switch failures. If you can centrally decide how to allocate
resources across the entire network, it is possible to run the network
much closer to maximum utilization. Keep in mind that provisioning links
in the network is done for coarse-grain application classes. TCP
congestion control still operates on a connection-by-connection basis,
and routing decisions are still made on top of the B4 topology. (As an
aside, it is worth noting that because B4 is a private WAN, Google is
free to run their own congestion control algorithm, such as BBR, without
fear that it will unfairly disadvantage other algorithms.)

One lesson to take away from systems like B4 is that the line between
traffic engineering and congestion control (as well as between traffic
engineering and routing) is fuzzy. There are different mechanisms
working to address the same general problem, and so there is no
fixed-and-hard line that says where one mechanism stops and another
begins. In short, layer boundaries become soft (and easy to move) when
the layers are implemented in software rather than hardware. This is
increasingly becoming the norm.

.. admonition:: Broader Perspective

   To continue reading about the cloudification of the Internet, see
   :ref:`Perspective: Big Data and Analytics`.

   To learn more about the B4, we recommend: `B4: Experience with a
   Globally Deployed Software Defined
   WAN <https://cseweb.ucsd.edu/~vahdat/papers/b4-sigcomm13.pdf>`__,
   August 2013.
