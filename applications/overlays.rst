9.4 Overlay Networks
====================

From its inception, the Internet has adopted a clean model, in which the
routers inside the network are responsible for forwarding packets from
source to destination, and application programs run on the hosts
connected to the edges of the network. The client/server paradigm
illustrated by the applications discussed in the first two sections of
this chapter certainly adhere to this model.

In the last few years, however, the distinction between *packet
forwarding* and *application processing* has become less clear. New
applications are being distributed across the Internet, and in many
cases these applications make their own forwarding decisions. These new
hybrid applications can sometimes be implemented by extending
traditional routers and switches to support a modest amount of
application-specific processing. For example, so-called *level-7
switches* sit in front of server clusters and forward HTTP requests to a
specific server based on the requested URL. However, *overlay networks*
are quickly emerging as the mechanism of choice for introducing new
functionality into the Internet.

.. _fig-overlay-net:
.. figure:: figures/f09-19-9780123850591.png
   :width: 300px
   :align: center

   Overlay network layered on top of a physical network.

You can think of an overlay as a logical network implemented on top of
some underlying network. By this definition, the Internet started out
as an overlay network on top of the links provided by the old
telephone network. :numref:`Figure %s <fig-overlay-net>` depicts an
overlay implemented on top of an underlying network. Each node in the
overlay also exists in the underlying network; it processes and
forwards packets in an application-specific way. The links that
connect the overlay nodes are implemented as tunnels through the
underlying network. Multiple overlay networks can exist on top of the
same underlying network—each implementing its own application-specific
behavior—and overlays can be nested, one on top of another. For
example, all of the example overlay networks discussed in this section
treat today’s Internet as the underlying network.

.. _fig-overlay-tunnel:
.. figure:: figures/f09-20-9780123850591.png
   :width: 500px
   :align: center

   Overlay nodes tunnel through physical nodes.

We have already seen examples of tunneling, for example, to implement
virtual private networks (VPNs). As a brief refresher, the nodes on
either end of a tunnel treat the multi-hop path between them as a
single logical link, the nodes that are tunneled through forward
packets based on the outer header, never aware that the end nodes have
attached an inner header. :numref:`Figure %s <fig-overlay-tunnel>`
shows three overlay nodes (A, B, and C) connected by a pair of
tunnels. In this example, overlay node B might make a forwarding
decision for packets from A to C based on the inner header (``IHdr``),
and then attach an outer header (``OHdr``) that identifies C as the
destination in the underlying network. Nodes A, B, and C are able to
interpret both the inner and outer header, whereas the intermediate
routers understand only the outer header. Similarly, A, B, and C have
addresses in both the overlay network and the underlying network, but
they are not necessarily the same; for example, their underlying
address might be a 32-bit IP address, while their overlay address
might be an experimental 128-bit address. In fact, the overlay need
not use conventional addresses at all but may route based on URLs,
domain names, an XML query, or even the content of the packet.

9.4.1 Routing Overlays
----------------------

The simplest kind of overlay is one that exists purely to support an
alternative routing strategy; no additional application-level processing
is performed at the overlay nodes. You can view a virtual private
network (VPN) as an example of a routing overlay, but one that doesn’t
so much define an alternative strategy or algorithm as it does
alternative routing table entries to be processed by the standard IP
forwarding algorithm. In this particular case, the overlay is said to
use “IP tunnels,” and the ability to utilize these VPNs is supported in
many commercial routers.

Suppose, however, you wanted to use a routing algorithm that commercial
router vendors were not willing to include in their products. How would
you go about doing it? You could simply run your algorithm on a
collection of end hosts, and tunnel through the Internet routers. These
hosts would behave like routers in the overlay network: As hosts they
are probably connected to the Internet by only one physical link, but as
a node in the overlay they would be connected to multiple neighbors via
tunnels.

Since overlays, almost by definition, are a way to introduce new
technologies independent of the standardization process, there are no
standard overlays we can point to as examples. Instead, we illustrate
the general idea of routing overlays by describing several experimental
systems that have been built by network researchers.

Experimental Versions of IP
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Overlays are ideal for deploying experimental versions of IP that you
hope will eventually take over the world. For example, IP multicast
started off as an extension to IP and even today is not enabled in
many Internet routers. The MBone (multicast backbone) was an overlay
network that implemented IP multicast on top of the unicast routing
provided by the Internet. A number of multimedia conference tools were
developed for and deployed on the Mbone. For example, IETF
meetings—which are a week long and attract thousands of
participants—were for many years broadcast over the MBone. (Today, the
wide availability of commercial conferencing tools have replaced the
MBone-based approach.)

Like VPNs, the MBone used both IP tunnels and IP addresses, but unlike
VPNs, the MBone implemented a different forwarding algorithm—forwarding
packets to all downstream neighbors in the shortest path multicast tree.
As an overlay, multicast-aware routers tunnel through legacy routers,
with the hope that one day there will be no more legacy routers.

The 6-BONE was a similar overlay that was used to incrementally deploy
IPv6. Like the MBone, the 6-BONE used tunnels to forward packets
through IPv4 routers. Unlike the MBone, however, 6-BONE nodes did not
simply provide a new interpretation of IPv4’s 32-bit
addresses. Instead, they forwarded packets based on IPv6’s 128-bit
address space. The 6-BONE also supported IPv6 multicast. (Today,
commercial routers support IPv6, but again, overlays are a valuable
approach while a new technology is being evaluated and tuned.)

End System Multicast
~~~~~~~~~~~~~~~~~~~~

Although IP multicast is popular with researchers and certain segments
of the networking community, its deployment in the global Internet has
been limited at best. In response, multicast-based applications like
videoconferencing have recently turned to an alternative strategy,
called *end system multicast*. The idea of end system multicast is to
accept that IP multicast will never become ubiquitous and to instead let
the end hosts that are participating in a particular multicast-based
application implement their own multicast trees.

Before describing how end system multicast works, it is important to
first understand that, unlike VPNs and the MBone, end system multicast
assumes that only Internet hosts (as opposed to Internet routers)
participate in the overlay. Moreover, these hosts typically exchange
messages with each other through UDP tunnels rather than IP tunnels,
making it easy to implement as regular application programs. This makes
it possible to view the underlying network as a fully connected graph,
since every host in the Internet is able to send a message to every
other host. Abstractly, then, end system multicast solves the following
problem: Starting with a fully connected graph representing the
Internet, the goal is to find the embedded multicast tree that spans all
the group members.

Note that there is a simpler version of this problem, enabled by the
ready availability of cloud-hosted VMs around the world. The
multicast-aware “end systems” can be VMs running at multiple sites.
As these sites are well-known and relatively fixed, it’s possible to
construct a static multicast tree in the cloud, and have the actual
end-hosts simply connect to the nearest cloud location. But for the
sake of completeness, the following describes the approach in its full
glory.

.. _fig-topology:
.. figure:: figures/f09-21-9780123850591.png
   :width: 400px
   :align: center

   Alternative multicast trees mapped onto a physical topology.

Since we take the underlying Internet to be fully connected, a naive
solution would be to have each source directly connected to each
member of the group. In other words, end system multicast could be
implemented by having each node send unicast messages to every group
member. To see the problem in doing this, especially compared to
implementing IP multicast in routers, consider the example topology in
:numref:`Figure %s <fig-topology>`. :numref:`Figure %s <fig-topology>`
depicts an example physical topology, where R1 and R2 are routers
connected by a low-bandwidth transcontinental link; A, B, C, and D are
end hosts; and link delays are given as edge weights. Assuming A wants
to send a multicast message to the other three hosts, :numref:`Figure
%s <fig-topology>` shows how naive unicast transmission would
work. This is clearly undesirable because the same message must
traverse the link A-R1 three times, and two copies of the message
traverse R1-R2. :numref:`Figure %s <fig-topology>` depicts the IP
multicast tree constructed by the Distance Vector Multicast Routing
Protocol (DVMRP). Clearly, this approach eliminates the redundant
messages. Without support from the routers, however, the best one can
hope for with end system multicast is a tree similar to the one shown
in :numref:`Figure %s <fig-topology>`. End system multicast defines an
architecture for constructing this tree.

.. _fig-layered-overlays:
.. figure:: figures/f09-22-9780123850591.png
   :width: 300px
   :align: center

   Multicast tree embedded in an overlay network.

The general approach is to support multiple levels of overlay
networks, each of which extracts a subgraph from the overlay below it,
until we have selected the subgraph that the application expects. For
end system multicast, in particular, this happens in two stages: First
we construct a simple *mesh* overlay on top of the fully connected
Internet, and then we select a multicast tree within this mesh. The
idea is illustrated in :numref:`Figure %s <fig-layered-overlays>`,
again assuming the four end hosts A, B, C, and D. The first step is
the critical one: Once we have selected a suitable mesh overlay, we
simply run a standard multicast routing algorithm (e.g., DVMRP) on top
of it to build the multicast tree. We also have the luxury of ignoring
the scalability issue that Internet-wide multicast faces since the
intermediate mesh can be selected to include only those nodes that
want to participate in a particular multicast group.

The key to constructing the intermediate mesh overlay is to select a
topology that roughly corresponds to the physical topology of the
underlying Internet, but we have to do this without anyone telling us
what the underlying Internet actually looks like since we are running
only on end hosts and not routers. The general strategy is for the end
hosts to measure the roundtrip latency to other nodes and decide to add
links to the mesh only when they like what they see. This works as
follows.

First, assuming a mesh already exists, each node exchanges the list of
all other nodes it believes is part of the mesh with its directly
connected neighbors. When a node receives such a membership list from a
neighbor, it incorporates that information into its membership list and
forwards the resulting list to its neighbors. This information
eventually propagates through the mesh, much as in a distance vector
routing protocol.

When a host wants to join the multicast overlay, it must know the IP
address of at least one other node already in the overlay. It then sends
a “join mesh” message to this node. This connects the new node to the
mesh by an edge to the known node. In general, the new node might send a
join message to multiple current nodes, thereby joining the mesh by
multiple links. Once a node is connected to the mesh by a set of links,
it periodically sends “keepalive” messages to its neighbors, letting
them know that it still wants to be part of the group.

When a node leaves the group, it sends a “leave mesh” message to its
directly connected neighbors, and this information is propagated to the
other nodes in the mesh via the membership list described above.
Alternatively, a node can fail or just silently decide to quit the
group, in which case its neighbors detect that it is no longer sending
“keep alive” messages. Some node departures have little effect on the
mesh, but should a node detect that the mesh has become partitioned due
to a departing node, it creates a new edge to a node in the other
partition by sending it a “join mesh” message. Note that multiple
neighbors can simultaneously decide that a partition has occurred in the
mesh, leading to multiple cross-partition edges being added to the mesh.

As described so far, we will end up with a mesh that is a subgraph of
the original fully connected Internet, but it may have suboptimal
performance because (1) initial neighbor selection adds random links to
the topology, (2) partition repair might add edges that are essential at
the moment but not useful in the long run, (3) group membership may
change due to dynamic joins and departures, and (4) underlying network
conditions may change. What needs to happen is that the system must
evaluate the value of each edge, resulting in new edges being added to
the mesh and existing edges being removed over time.

To add new edges, each node *i* periodically probes some random member
*j* that it is not currently connected to in the mesh, measures the
round-trip latency of edge *(i,j)*, and then evaluates the utility of
adding this edge. If the utility is above a certain threshold, link
*(i,j)* is added to the mesh. Evaluating the utility of adding edge
*(i,j)* might look something like this:

::

   EvaluateUtility(j)
       utility = 0
       for each member m not equal to i
           CL = current latency to node m along route through mesh
           NL = new latency to node m along mesh if edge (i,j) is added}
           if (NL < CL) then
               utility += (CL - NL)/CL
       return utility

Deciding to remove an edge is similar, except each node *i* computes the
cost of each link to current neighbor *j* as follows:

::

   EvaluateCost(j)
       Cost[i,j] = number of members for which i uses j as next hop
       Cost[j,i] = number of members for which j uses i as next hop
       return max(Cost[i,j], Cost[j,i])

It then picks the neighbor with the lowest cost, and drops it if the
cost falls below a certain threshold.

Finally, since the mesh is maintained using what is essentially a
distance vector protocol, it is trivial to run DVMRP to find an
appropriate multicast tree in the mesh. Note that, although it is not
possible to prove that the protocol just described results in the
optimum mesh network, thereby allowing DVMRP to select the best possible
multicast tree, both simulation and extensive practical experience
suggests that it does a good job.

Resilient Overlay Networks
~~~~~~~~~~~~~~~~~~~~~~~~~~

Another function that can be performed by an overlay is to find
alternative routes for traditional unicast applications. Such overlays
exploit the observation that the triangle inequality does not hold in
the Internet. :numref:`Figure %s <fig-triangle>` illustrates what we
mean by this.  It is not uncommon to find three sites in the
Internet—call them A, B, and C—such that the latency between A and B
is greater than the sum of the latencies from A to C and from C
to B. That is, sometimes you would be better off indirectly sending
your packets via some intermediate node than sending them directly to
the destination.

.. _fig-triangle:
.. figure:: figures/f09-23-9780123850591.png
   :width: 600px
   :align: center

   The triangle inequality does not necessarily hold in networks.

How can this be? Well, the Border Gateway Protocol (BGP) never promised
that it would find the *shortest* route between any two sites; it only
tries to find *some* route. To make matters more complex, BGP’s routes
are heavily influenced by policy issues, such as who is paying whom to
carry their traffic. This often happens, for example, at peering points
between major backbone ISPs. In short, that the triangle inequality does
not hold in the Internet should not come as a surprise.

How do we exploit this observation? The first step is to realize that
there is a fundamental tradeoff between the scalability and optimality
of a routing algorithm. On the one hand, BGP scales to very large
networks, but often does not select the best possible route and is slow
to adapt to network outages. On the other hand, if you were only worried
about finding the best route among a handful of sites, you could do a
much better job of monitoring the quality of every path you might use,
thereby allowing you to select the best possible route at any moment in
time.

An experimental overlay, called the Resilient Overlay Network (RON), did
exactly this. RON scaled to only a few dozen nodes because it used an *N
× N* strategy of closely monitoring (via active probes) three aspects of
path quality—latency, available bandwidth, and loss probability—between
every pair of sites. It was then able to both select the optimal route
between any pair of nodes, and rapidly change routes should network
conditions change. Experience showed that RON was able to deliver modest
performance improvements to applications, but more importantly, it
recovered from network failures much more quickly. For example, during
one 64-hour period in 2001, an instance of RON running on 12 nodes
detected 32 outages lasting over 30 minutes, and it was able to recover
from all of them in less than 20 seconds on average. This experiment
also suggested that forwarding data through just one intermediate node
is usually sufficient to recover from Internet failures.

Since RON was not designed to be a scalable approach, it is not possible
to use RON to help random host A communicate with random host B; A and B
have to know ahead of time that they are likely to communicate and then
join the same RON. However, RON seems like a good idea in certain
settings, such as when connecting a few dozen corporate sites spread
across the Internet or allowing you and 50 of your friends to establish
your own private overlay for the sake of running some application.
(Today, this idea is put to practice with the marketing name
*Software-Defined WAN*, or *SD-WAN*.) The real question, though, is what
happens when everyone starts to run their own RON. Does the overhead of
millions of RONs aggressively probing paths swamp the network, and does
anyone see improved behavior when many RONs compete for the same paths?
These questions are still unanswered.

.. _key-virtualization:
.. admonition:: Key Takeaway

   All of these overlays illustrate a concept that is central to
   computer networks in general: *virtualization*. That is, it is
   possible to build a virtual network from abstract (logical) resources
   on top of a physical network constructed from physical resources.
   Moreover, it is possible to stack these virtualized networks on top
   of each other and for multiple virtual networks to coexist at the same
   level. Each virtual network, in turn, provides new capabilities that
   are of value to some set of users, applications, or higher-level
   networks. :ref:`[Next] <key-nested>`

9.4.2 Peer-to-Peer Networks
---------------------------

Music-sharing applications like Napster and KaZaA introduced the term
“peer-to-peer” into the popular vernacular. But what exactly does it
mean for a system to be “peer-to-peer”? Certainly in the context of
sharing MP3 files it means not having to download music from a central
site, but instead being able to access music files directly from whoever
in the Internet happens to have a copy stored on their computer. More
generally then, we could say that a peer-to-peer network allows a
community of users to pool their resources (content, storage, network
bandwidth, disk bandwidth, CPU), thereby providing access to a larger
archival store, larger video/audio conferences, more complex searches
and computations, and so on than any one user could afford individually.

Quite often, attributes like *decentralized* and *self-organizing* are
mentioned when discussing peer-to-peer networks, meaning that individual
nodes organize themselves into a network without any centralized
coordination. If you think about it, terms like these could be used to
describe the Internet itself. Ironically, however, Napster was not a
true peer-to-peer system by this definition since it depended on a
central registry of known files, and users had to search this directory
to find what machine offered a particular file. It was only the last
step—actually downloading the file—that took place between machines that
belong to two users, but this is little more than a traditional
client/server transaction. The only difference is that the server is
owned by someone just like you rather than a large corporation.

So we are back to the original question: What’s interesting about
peer-to-peer networks? One answer is that both the process of locating
an object of interest and the process of downloading that object onto
your local machine happen without your having to contact a centralized
authority, and at the same time the system is able to scale to millions
of nodes. A peer-to-peer system that can accomplish these two tasks in a
decentralized manner turns out to be an overlay network, where the nodes
are those hosts that are willing to share objects of interest (e.g.,
music and other assorted files), and the links (tunnels) connecting
these nodes represent the sequence of machines that you have to visit to
track down the object you want. This description will become clearer
after we look at two examples.

Gnutella
~~~~~~~~

Gnutella is an early peer-to-peer network that attempted to
distinguish between exchanging music (which likely violates somebody’s
copyright) and the general sharing of files (which must be good since
we’ve been taught to share since the age of two). What’s interesting
about Gnutella is that it was one of the first such systems to not
depend on a centralized registry of objects. Instead, Gnutella
participants arrange themselves into an overlay network similar to the
one shown in :numref:`Figure %s <fig-gnutella>`. That is, each node
that runs the Gnutella software (i.e., implements the Gnutella
protocol) knows about some set of other machines that also run the
Gnutella software. The relationship “A and B know each other”
corresponds to the edges in this graph. (We’ll talk about how this
graph is formed in a moment.)

.. _fig-gnutella:
.. figure:: figures/f09-24-9780123850591.png
   :width: 300px
   :align: center

   Example topology of a gnutella peer-to-peer network.

Whenever the user on a given node wants to find an object, Gnutella
sends a QUERY message for the object—for example, specifying the file’s
name—to its neighbors in the graph. If one of the neighbors has the
object, it responds to the node that sent it the query with a QUERY
RESPONSE message, specifying where the object can be downloaded (e.g.,
an IP address and TCP port number). That node can subsequently use GET
or PUT messages to access the object. If the node cannot resolve the
query, it forwards the QUERY message to each of its neighbors (except
the one that sent it the query), and the process repeats. In other
words, Gnutella floods the overlay to locate the desired object.
Gnutella sets a TTL on each query so this flood does not continue
indefinitely.

In addition to the TTL and query string, each QUERY message contains a
unique query identifier (QID), but it does not contain the identity of
the original message source. Instead, each node maintains a record of
the QUERY messages it has seen recently: both the QID and the neighbor
that sent it the QUERY. It uses this history in two ways. First, if it
ever receives a QUERY with a QID that matches one it has seen recently,
the node does not forward the QUERY message. This serves to cut off
forwarding loops more quickly than the TTL might have done. Second,
whenever the node receives a QUERY RESPONSE from a downstream neighbor,
it knows to forward the response to the upstream neighbor that
originally sent it the QUERY message. In this way, the response works
its way back to the original node without any of the intermediate nodes
knowing who wanted to locate this particular object in the first place.

Returning to the question of how the graph evolves, a node certainly has
to know about at least one other node when it joins a Gnutella overlay.
The new node is attached to the overlay by at least this one link. After
that, a given node learns about other nodes as the result of QUERY
RESPONSE messages, both for objects it requested and for responses that
just happen to pass through it. A node is free to decide which of the
nodes it discovers in this way that it wants to keep as a neighbor. The
Gnutella protocol provides PING and PONG messages by which a node probes
whether or not a given neighbor still exists and that neighbor’s
response, respectively.

It should be clear that Gnutella as described here is not a particularly
clever protocol, and subsequent systems have tried to improve upon it.
One dimension along which improvements are possible is in how queries
are propagated. Flooding has the nice property that it is guaranteed to
find the desired object in the fewest possible hops, but it does not
scale well. It is possible to forward queries randomly, or according to
the probability of success based on past results. A second dimension is
to proactively replicate the objects, since the more copies of a given
object there are, the easier it should be to find a copy. Alternatively,
one could develop a completely different strategy, which is the topic we
consider next.

Structured Overlays
~~~~~~~~~~~~~~~~~~~

At the same time file sharing systems started fighting to fill the void
left by Napster, the research community began to explore an alternative
design for peer-to-peer networks. We refer to these networks as
*structured*, to contrast them with the essentially random
(unstructured) way in which a Gnutella network evolves. Unstructured
overlays like Gnutella employ trivial overlay construction and
maintenance algorithms, but the best they can offer is unreliable,
random search. In contrast, structured overlays are designed to conform
to a particular graph structure that allows reliable and efficient
(probabilistically bounded delay) object location, in return for
additional complexity during overlay construction and maintenance.

If you think about what we are trying to do at a high level, there are
two questions to consider: (1) How do we map objects onto nodes, and (2)
How do we route a request to the node that is responsible for a given
object? We start with the first question, which has a simple statement:
How do we map an object with name *x* into the address of some node *n*
that is able to serve that object? While traditional peer-to-peer
networks have no control over which node hosts object *x*, if we could
control how objects get distributed over the network, we might be able
to do a better job of finding those objects at a later time.

A well-known technique for mapping names into an address is to use a
hash table, so that

.. centered:: *hash(x) → n*

implies object *x* is first placed on node *n*, and at a later time a
client trying to locate *x* would only have to perform the hash of *x*
to determine that it is on node *n*. A hash-based approach has the nice
property that it tends to spread the objects evenly across the set of
nodes, but straightforward hashing algorithms suffer from a fatal flaw:
How many possible values of *n* should we allow? (In hashing
terminology, how many buckets should there be?) Naively, we could decide
that there are, say, 101 possible hash values, and we use a modulo hash
function; that is,

::

   hash(x)
       return x % 101

Unfortunately, if there are more than 101 nodes willing to host objects,
then we can’t take advantage of all of them. On the other hand, if we
select a number larger than the largest possible number of nodes, then
there will be some values of *x* that will hash into an address for a
node that does not exist. There is also the not-so-small issue of
translating the value returned by the hash function into an actual IP
address.

.. _fig-unitcircle:
.. figure:: figures/f09-25-9780123850591.png
   :width: 300px
   :align: center

   Both nodes and objects map (hash) onto the ID space, where objects are
   maintained at the nearest node in this space.

To address these issues, structured peer-to-peer networks use an
algorithm known as *consistent hashing*, which hashes a set of objects
*x* uniformly across a large ID space. :numref:`Figure %s <fig-unitcircle>`
visualizes a 128-bit ID space as a circle, where we use the algorithm to
place both objects

.. centered:: *hash(ObjectName) → ObjectID*

and nodes

.. centered:: *hash(IPAddr) → NodeID*

onto this circle. Since a 128-bit ID space is enormous, it is unlikely
that an object will hash to exactly the same ID as a machine’s IP
address hashes to. To account for this unlikelihood, each object is
maintained on the node whose ID is *closest*, in this 128-bit space, to
the object ID. In other words, the idea is to use a high-quality hash
function to map both nodes and objects into the same large, sparse ID
space; you then map objects to nodes by numerical proximity of their
respective identifiers. Like ordinary hashing, this distributes objects
fairly evenly across nodes, but, unlike ordinary hashing, only a small
number of objects have to move when a node (hash bucket) joins or
leaves.

.. _fig-locate:
.. figure:: figures/f09-26-9780123850591.png
   :width: 300px
   :align: center

   Objects are located by routing through the peer-to-peer overlay network.

We now turn to the second question—how does a user that wants to access
object *x* know which node is closest in *x*\ ’s ID in this space? One
possible answer is that each node keeps a complete table of node IDs and
their associated IP addresses, but this would not be practical for a
large network. The alternative, which is the approach used by structured
peer-to-peer networks, is to *route a message to this node!* In other
words, if we construct the overlay in a clever way—which is the same as
saying that we need to choose entries for a node’s routing table in a
clever way—then we find a node simply by routing toward it.
Collectively, this approach is sometimes called a *distributed hash
table* (DHT), since conceptually, the hash table is distributed over all
the nodes in the network.

:numref:`Figure %s <fig-locate>` illustrates what happens for a simple
28-bit ID space. To keep the discussion as concrete as possible, we
consider the approach used by a particular peer-to-peer network called
*Pastry*.  Other systems work in a similar manner.

Suppose you are at the node with id ``65a1fc`` (hex) and you are trying
to locate the object with ID ``d46a1c``. You realize that your ID shares
nothing with the object’s, but you know of a node that shares at least
the prefix ``d``. That node is closer than you in the 128-bit ID space,
so you forward the message to it. (We do not give the format of the
message being forwarded, but you can think of it as saying “locate
object ``d46a1c``”.) Assuming node ``d13da3`` knows of another node that
shares an even longer prefix with the object, it forwards the message
on. This process of moving closer in ID-space continues until you reach
a node that knows of no closer node. This node is, by definition, the
one that hosts the object. Keep in mind that as we logically move
through “ID space” the message is actually being forwarded, node to
node, through the underlying Internet.

Each node maintains a both routing table (more below) and the IP
addresses of a small set of numerically larger and smaller node IDs.
This is called the node’s *leaf set*. The relevance of the leaf set is
that, once a message is routed to any node in the same leaf set as the
node that hosts the object, that node can directly forward the message
to the ultimate destination. Said another way, the leaf set facilitates
correct and efficient delivery of a message to the numerically closest
node, even though multiple nodes may exist that share a maximal length
prefix with the object ID. Moreover, the leaf set makes routing more
robust because any of the nodes in a leaf set can route a message just
as well as any other node in the same set. Thus, if one node is unable
to make progress routing a message, one of its neighbors in the leaf set
may be able to. In summary, the routing procedure is defined as follows:

::

   Route(D)
       if D is within range of my leaf set
           forward to numerically closest member in leaf set
       else
           let l = length of shared prefix
           let d = value of l-th digit in D's address
           if RouteTab[l,d] exists
               forward to RouteTab[l,d]
           else
               forward to known node with at least as long a shared prefix
               and numerically closer than this node

The routing table, denoted ``RouteTab``, is a two-dimensional array. It
has a row for every hex digit in an ID (there such 32 digits in a
128-bit ID) and a column for every hex value (there are obviously 16
such values). Every entry in row *i* shares a prefix of length *i* with
this node, and within this row the entry in column *j* has the hex value
*j* in the *i+1*-th position. :numref:`Figure %s <fig-rt>` shows the first three
rows of an example routing table for node ``65a1fcx``, where *x* denotes
an unspecified suffix. This figure shows the ID prefix matched by every
entry in the table. It does not show the actual value contained in this
entry—the IP address of the next node to route to.

.. _fig-rt:
.. figure:: figures/f09-27-9780123850591.png
   :width: 500px
   :align: center

   Example routing table at the node with ID 65alcx

.. _fig-addnode:
.. figure:: figures/f09-28-9780123850591.png
   :width: 500px
   :align: center

   Adding a node to the network.

Adding a node to the overlay works much like routing a “locate object
message” to an object. The new node must know of at least one current
member. It asks this member to route an “add node message” to the node
numerically closest to the ID of the joining node, as shown in
:numref:`Figure %s <fig-addnode>`. It is through this routing process
that the new node learns about other nodes with a shared prefix and is
able to begin filling out its routing table. Over time, as additional
nodes join the overlay, existing nodes also have the option of
including information about the newly joined node in their routing
tables. They do this when the new node adds a longer prefix than they
currently have in their table. Neighbors in the leaf sets also
exchange routing tables with each other, which means that over time
routing information propagates through the overlay.

The reader may have noticed that although structured overlays provide a
probabilistic bound on the number of routing hops required to locate a
given object—the number of hops in Pastry is bounded by :math:`log_{16}N`, 
where N is the number of nodes in the overlay—each hop may contribute
substantial delay. This is because each intermediate node may be at a
random location in the Internet. (In the worst case, each node is on a
different continent!) In fact, in a world-wide overlay network using the
algorithm as described above, the expected delay of each hop is the
average delay among all pairs of nodes in the Internet! Fortunately, one
can do much better in practice. The idea is to choose each routing table
entry such that it refers to a nearby node in the underlying physical
network, among all nodes with an ID prefix that is appropriate for the
entry. It turns out that doing so achieves end-to-end routing delays
that are within a small factor of the delay between source and
destination node.

Finally, the discussion up to this point has focused on the general
problem of locating objects in a peer-to-peer network. Given such a
routing infrastructure, it is possible to build different services. For
example, a file sharing service would use file names as object names. To
locate a file, you first hash its name into a corresponding object ID
and then route a “locate object message” to this ID. The system might
also replicate each file across multiple nodes to improve availability.
Storing multiple copies on the leaf set of the node to which a given
file normally routes would be one way of doing this. Keep in mind that
even though these nodes are neighbors in the ID space, they are likely
to be physically distributed across the Internet. Thus, while a power
outage in an entire city might take down physically close replicas of a
file in a traditional file system, one or more replicas would likely
survive such a failure in a peer-to-peer network.

Services other than file sharing can also be built on top of distributed
hash tables. Consider multicast applications, for example. Instead of
constructing a multicast tree from a mesh, one could construct the tree
from edges in the structured overlay, thereby amortizing the cost of
overlay construction and maintenance across several applications and
multicast groups.

BitTorrent
~~~~~~~~~~

BitTorrent is a peer-to-peer file sharing protocol devised by Bram
Cohen. It is based on replicating the file or, rather, replicating
segments of the file, which are called *pieces*. Any particular piece
can usually be downloaded from multiple peers, even if only one peer has
the entire file. The primary benefit of BitTorrent’s replication is
avoiding the bottleneck of having only one source for a file. This is
particularly useful when you consider that any given computer has a
limited speed at which it can serve files over its uplink to the
Internet, often quite a low limit due to the asymmetric nature of most
broadband networks. The beauty of BitTorrent is that replication is a
natural side effect of the downloading process: As soon as a peer
downloads a particular piece, it becomes another source for that piece.
The more peers downloading pieces of the file, the more piece
replication occurs, distributing the load proportionately, and the more
total bandwidth is available to share the file with others. Pieces are
downloaded in random order to avoid a situation where peers find
themselves lacking the same set of pieces.

Each file is shared via its own independent BitTorrent network, called a
*swarm*. (A swarm could potentially share a set of files, but we
describe the single file case for simplicity.) The lifecycle of a
typical swarm is as follows. The swarm starts as a singleton peer with a
complete copy of the file. A node that wants to download the file joins
the swarm, becoming its second member, and begins downloading pieces of
the file from the original peer. In doing so, it becomes another source
for the pieces it has downloaded, even if it has not yet downloaded the
entire file. (In fact, it is common for peers to leave the swarm once
they have completed their downloads, although they are encouraged to
stay longer.) Other nodes join the swarm and begin downloading pieces
from multiple peers, not just the original peer. See :numref:`Figure %s
<fig-bitTorrentSwarm>`.

.. _fig-bitTorrentSwarm:
.. figure:: figures/f09-29-9780123850591.png
   :width: 500px
   :align: center

   Peers in a BitTorrent swarm download from other peers that may not yet
   have the complete file.

If the file remains in high demand, with a stream of new peers replacing
those who leave the swarm, the swarm could remain active indefinitely;
if not, it could shrink back to include only the original peer until new
peers join the swarm.

Now that we have an overview of BitTorrent, we can ask how requests are
routed to the peers that have a given piece. To make requests, a
would-be downloader must first join the swarm. It starts by downloading
a file containing meta-information about the file and swarm. The file,
which may be easily replicated, is typically downloaded from a web
server and discovered by following links from Web pages. It contains:

-  The target file’s size

-  The piece size

-  SHA-1 hash values precomputed from each piece

-  The URL of the swarm’s *tracker*

A tracker is a server that tracks a swarm’s current membership. We’ll
see later that BitTorrent can be extended to eliminate this point of
centralization, with its attendant potential for bottleneck or failure.

The would-be downloader then joins the swarm, becoming a peer, by
sending a message to the tracker giving its network address and a peer
ID that it has generated randomly for itself. The message also carries a
SHA-1 hash of the main part of the file, which is used as a swarm ID.

Let’s call the new peer P. The tracker replies to P with a partial list
of peers giving their IDs and network addresses, and P establishes
connections, over TCP, with some of these peers. Note that P is directly
connected to just a subset of the swarm, although it may decide to
contact additional peers or even request more peers from the tracker. To
establish a BitTorrent connection with a particular peer after their TCP
connection has been established, P sends P’s own peer ID and swarm ID,
and the peer replies with its peer ID and swarm ID. If the swarm IDs
don’t match, or the reply peer ID is not what P expects, the connection
is aborted.

The resulting BitTorrent connection is symmetric: Each end can download
from the other. Each end begins by sending the other a bitmap reporting
which pieces it has, so each peer knows the other’s initial state.
Whenever a downloader (D) finishes downloading another piece, it sends a
message identifying that piece to each of its directly connected peers,
so those peers can update their internal representation of D’s state.
This, finally, is the answer to the question of how a download request
for a piece is routed to a peer that has the piece, because it means
that each peer knows which directly connected peers have the piece. If D
needs a piece that none of its connections has, it could connect to more
or different peers (it can get more from the tracker) or occupy itself
with other pieces in hopes that some of its connections will obtain the
piece from their connections.

How are objects—in this case, pieces—mapped onto peer nodes? Of course
each peer eventually obtains all the pieces, so the question is really
about which pieces a peer has at a given time before it has all the
pieces or, equivalently, about the order in which a peer downloads
pieces. The answer is that they download pieces in random order, to keep
them from having a strict subset or superset of the pieces of any of
their peers.

The BitTorrent described so far utilizes a central tracker that
constitutes a single point of failure for the swarm and could
potentially be a performance bottleneck. Also, providing a tracker can
be a nuisance for someone who would like to make a file available via
BitTorrent. Newer versions of BitTorrent additionally support
“trackerless” swarms that use a DHT-based implementation. BitTorrent
client software that is trackerless capable implements not just a
BitTorrent peer but also what we’ll call a *peer finder* (the BitTorrent
terminology is simply *node*), which the peer uses to find peers.

Peer finders form their own overlay network, using their own protocol
over UDP to implement a DHT. Furthermore, a peer finder network includes
peer finders whose associated peers belong to different swarms. In other
words, while each swarm forms a distinct network of BitTorrent peers, a
peer finder network instead spans swarms.

Peer finders randomly generate their own finder IDs, which are the same
size (160 bits) as swarm IDs. Each finder maintains a modest table
containing primarily finders (and their associated peers) whose IDs are
close to its own, plus some finders whose IDs are more distant. The
following algorithm ensures that finders whose IDs are close to a given
swarm ID are likely to know of peers from that swarm; the algorithm
simultaneously provides a way to look them up. When a finder F needs to
find peers from a particular swarm, it sends a request to the finders in
its table whose IDs are close to that swarm’s ID. If a contacted finder
knows of any peers for that swarm, it replies with their contact
information. Otherwise, it replies with the contact information of the
finders in its table that are close to the swarm, so that F can
iteratively query those finders.

After the search is exhausted, because there are no finders closer to
the swarm, F inserts the contact information for itself and its
associated peer into the finders closest to the swarm. The net effect is
that peers for a particular swarm get entered in the tables of the
finders that are close to that swarm.

The above scheme assumes that F is already part of the finder network,
that it already knows how to contact some other finders. This assumption
is true for finder installations that have run previously, because they
are supposed to save information about other finders, even across
executions. If a swarm uses a tracker, its peers are able to tell their
finders about other finders (in a reversal of the peer and finder roles)
because the BitTorrent peer protocol has been extended to exchange
finder contact information. But, how can a newly installed finder
discover other finders? The files for trackerless swarms include contact
information for one or a few finders, instead of a tracker URL, for just
that situation.

An unusual aspect of BitTorrent is that it deals head-on with the issue
of fairness, or good “network citizenship.” Protocols often depend on
the good behavior of individual peers without being able to enforce it.
For example, an unscrupulous Ethernet peer could get better performance
by using a backoff algorithm that is more aggressive than exponential
backoff, or an unscrupulous TCP peer could get better performance by not
cooperating in congestion control.

The good behavior that BitTorrent depends on is peers uploading pieces
to other peers. Since the typical BitTorrent user just wants to download
the file as quickly as possible, there is a temptation to implement a
peer that tries to download all the pieces while doing as little
uploading as possible—this is a bad peer. To discourage bad behavior,
the BitTorrent protocol includes mechanisms that allow peers to reward
or punish each other. If a peer is misbehaving by not nicely uploading
to another peer, the second peer can *choke* the bad peer: It can decide
to stop uploading to the bad peer, at least temporarily, and send it a
message saying so. There is also a message type for telling a peer that
it has been unchoked. The choking mechanism is also used by a peer to
limit the number of its active BitTorrent connections, to maintain good
TCP performance. There are many possible choking algorithms, and
devising a good one is an art.

9.4.3 Content Distribution Networks
-----------------------------------

We have already seen how HTTP running over TCP allows web browsers to
retrieve pages from web servers. However, anyone who has waited an
eternity for a Web page to return knows that the system is far from
perfect. Considering that the backbone of the Internet is now
constructed from 40-Gbps links, it’s not obvious why this should happen.
It is generally agreed that when it comes to downloading Web pages there
are four potential bottlenecks in the system:

-  *The first mile.* The Internet may have high-capacity links in it,
   but that doesn’t help you download a Web page any faster when you’re
   connected by a 1.5Mbps DSL line or a poorly performing wireless link.

-  *The last mile.* The link that connects the server to the Internet
   can be overloaded by too many requests, even if the aggregate
   bandwidth of that link is quite high.

-  *The server itself.* A server has a finite amount of resources (CPU,
   memory, disk bandwidth, etc.) and can be overloaded by too many
   concurrent requests.

-  *Peering points.* The handful of ISPs that collectively implement the
   backbone of the Internet may internally have high-bandwidth pipes,
   but they have little motivation to provide high-capacity connectivity
   to their peers. If you are connected to ISP A and the server is
   connected to ISP B, then the page you request may get dropped at the
   point where A and B peer with each other.

There’s not a lot anyone except you can do about the first problem, but
it is possible to use replication to address the remaining problems.
Systems that do this are often called *Content Distribution Networks*
(CDNs). Akamai operates what is probably the best-known CDN.

The idea of a CDN is to geographically distribute a collection of
*server surrogates* that cache pages normally maintained in some set
of *backend servers*. Thus, rather than having millions of users wait
forever to contact when a big news story breaks—such a situation is
known as a *flash crowd*—it is possible to spread this load across
many servers. Moreover, rather than having to traverse multiple ISPs
to reach ``www.cnn.com``, if these surrogate servers happen to be
spread across all the backbone ISPs, then it should be possible to
reach one without having to cross a peering point. Clearly,
maintaining thousands of surrogate servers all over the Internet is
too expensive for any one site that wants to provide better access to
its Web pages. Commercial CDNs provide this service for many sites,
thereby amortizing the cost across many customers.

Although we call them surrogate servers, in fact, they can just as
correctly be viewed as caches. If they don’t have a page that has been
requested by a client, they ask the backend server for it. In practice,
however, the backend servers proactively replicate their data across the
surrogates rather than wait for surrogates to request it on demand. It’s
also the case that only static pages, as opposed to dynamic content, are
distributed across the surrogates. Clients have to go to the backend
server for any content that either changes frequently (e.g., sports
scores and stock quotes) or is produced as the result of some
computation (e.g., a database query).

.. _fig-cdn:
.. figure:: figures/f09-30-9780123850591.png
   :width: 600px
   :align: center

   Components in a Content Distribution Network (CDN).

Having a large set of geographically distributed servers does not fully
solve the problem. To complete the picture, CDNs also need to provide a
set of *redirectors* that forward client requests to the most
appropriate server, as shown in :numref:`Figure %s <fig-cdn>`. The primary
objective of the redirectors is to select the server for each request
that results in the best *response time* for the client. A secondary
objective is for the system as a whole to process as many requests per
second as the underlying hardware (network links and web servers) is
able to support. The average number of requests that can be satisfied in
a given time period—known as the *system throughput*—is primarily an
issue when the system is under heavy load, such as when a flash crowd is
accessing a small set of pages or a Distributed Denial of Service (DDoS)
attacker is targeting a particular site, as happened to CNN, Yahoo, and
several other high-profile sites in February 2000.

CDNs use several factors to decide how to distribute client requests.
For example, to minimize response time, a redirector might select a
server based on its *network proximity*. In contrast, to improve the
overall system throughput, it is desirable to evenly *balance* the load
across a set of servers. Both throughput and response time are improved
if the distribution mechanism takes *locality* into consideration; that
is, it selects a server that is likely to already have the page being
requested in its cache. The exact combination of factors that should be
employed by a CDN is open to debate. This section considers some of the
possibilities.

Mechanisms
~~~~~~~~~~

As described so far, a redirector is just an abstract function, although
it sounds like what something a router might be asked to do since it
logically forwards a request message much like a router forwards
packets. In fact, there are several mechanisms that can be used to
implement redirection. Note that for the purpose of this discussion we
assume that each redirector knows the address of every available server.
(From here on, we drop the “surrogate” qualifier and talk simply in
terms of a set of servers.) In practice, some form of out-of-band
communication takes place to keep this information up-to-date as servers
come and go.

First, redirection could be implemented by augmenting DNS to return
different server addresses to clients. For example, when a client asks
to resolve the name ``www.cnn.com``, the DNS server could return the
IP address of a server hosting CNN’s Web pages that is known to have
the lightest load.  Alternatively, for a given set of servers, it
might just return addresses in a round-robin fashion. Note that the
granularity of DNS-based redirection is usually at the level of a site
(e.g., ``cnn.com``) rather than a specific URL (e.g.,
``https://www.cnn.com/2020/11/12/politics/biden-wins-arizona/index.html``). However,
when returning an embedded link, the server can rewrite the URL,
thereby effectively pointing the client at the most appropriate server
for that specific object.

Commercial CDNs essentially use a combination of URL rewriting and
DNS-based redirection. For scalability reasons, the high-level DNS
server first points to a regional-level DNS server, which replies with
the actual server address. In order to respond to changes quickly, the
DNS servers tweak the TTL of the resource records they return to a very
short period, such as 20 seconds. This is necessary so clients don’t
cache results and thus fail to go back to the DNS server for the most
recent URL-to-server mapping.

Another possibility is to use the HTTP redirect feature: The client
sends a request message to a server, which responds with a new (better)
server that the client should contact for the page. Unfortunately,
server-based redirection incurs an additional round-trip time across the
Internet, and, even worse, servers can be vulnerable to being overloaded
by the redirection task itself. Instead, if there is a node close to the
client (e.g., a local Web proxy) that is aware of the available servers,
then it can intercept the request message and instruct the client to
instead request the page from an appropriate server. In this case,
either the redirector would need to be on a choke point so that all
requests leaving the site pass through it, or the client would have to
cooperate by explicitly addressing the proxy (as with a classical,
rather than transparent, proxy).

At this point you may be wondering what CDNs have to do with overlay
networks, and while viewing a CDN as an overlay is a bit of a stretch,
they do share one very important trait in common. Like an overlay node,
a proxy-based redirector makes an application-level routing decision.
Rather than forward a packet based on an address and its knowledge of
the network topology, it forwards HTTP requests based on a URL and its
knowledge of the location and load of a set of servers. Today’s Internet
architecture does not support redirection directly—where by “directly”
we mean the client sends the HTTP request to the redirector, which
forwards to the destination—so instead redirection is typically
implemented indirectly by having the redirector return the appropriate
destination address and the client contacts the server itself.

Policies
~~~~~~~~

We now consider some example policies that redirectors might use to
forward requests. Actually, we have already suggested one simple
policy—round-robin. A similar scheme would be to simply select one of
the available servers at random. Both of these approaches do a good job
of spreading the load evenly across the CDN, but they do not do a
particularly good job of lowering the client-perceived response time.

It’s obvious that neither of these two schemes takes network proximity
into consideration, but, just as importantly, they also ignore locality.
That is, requests for the same URL are forwarded to different servers,
making it less likely that the page will be served from the selected
server’s in-memory cache. This forces the server to retrieve the page
from its disk, or possibly even from the backend server. How can a
distributed set of redirectors cause requests for the same page to go to
the same server (or small set of servers) without global coordination?
The answer is surprisingly simple: All redirectors use some form of
hashing to deterministically map URLs into a small range of values. The
primary benefit of this approach is that no inter-redirector
communication is required to achieve coordinated operation; no matter
which redirector receives a URL, the hashing process produces the same
output.

So what makes for a good hashing scheme? The classic *modulo* hashing
scheme—which hashes each URL modulo the number of servers—is not
suitable for this environment. This is because should the number of
servers change, the modulo calculation will result in a diminishing
fraction of the pages keeping their same server assignments. While we do
not expect frequent changes in the set of servers, the fact that the
addition of new servers into the set will cause massive reassignment is
undesirable.

An alternative is to use the same *consistent hashing* algorithm
discussed in the previous section. Specifically, each redirector first
hashes every server into the unit circle. Then, for each URL that
arrives, the redirector also hashes the URL to a value on the unit
circle, and the URL is assigned to the server that lies closest on the
circle to its hash value. If a node fails in this scheme, its load
shifts to its neighbors (on the unit circle), so the addition or removal
of a server only causes local changes in request assignments. Note that
unlike the peer-to-peer case, where a message is routed from one node to
another in order to find the server whose ID is closest to the objects,
each redirector knows how the set of servers map onto the unit circle,
so they can each, independently, select the “nearest” one.

This strategy can easily be extended to take server load into account.
Assume the redirector knows the current load of each of the available
servers. This information may not be perfectly up-to-date, but we can
imagine the redirector simply counting how many times it has forwarded a
request to each server in the last few seconds and using this count as
an estimate of that server’s current load. Upon receiving a URL, the
redirector hashes the URL plus each of the available servers and sorts
the resulting values. This sorted list effectively defines the order in
which the redirector will consider the available servers. The redirector
then walks down this list until it finds a server whose load is below
some threshold. The benefit of this approach compared to plain
consistent hashing is that server order is different for each URL, so if
one server fails, its load is distributed evenly among the other
machines. This approach is the basis for the Cache Array Routing
Protocol (CARP) and is shown in pseudocode below.

::

   SelectServer(URL, S)
       for each server s in server set S
           weight[s] = hash(URL, address[s])
       sort weight
       for each server s in decreasing order of weight
           if Load(s) < threshold then
               return s
          return server with highest weight

As the load increases, this scheme changes from using only the first
server on the sorted list to spreading requests across several servers.
Some pages normally handled by busy servers will also start being
handled by less busy servers. Since this process is based on aggregate
server load rather than the popularity of individual pages, servers
hosting some popular pages may find more servers sharing their load than
servers hosting collectively unpopular pages. In the process, some
unpopular pages will be replicated in the system simply because they
happen to be primarily hosted on busy servers. At the same time, if some
pages become extremely popular, it is conceivable that all of the
servers in the system could be responsible for serving them.

Finally, it is possible to introduce network proximity into the
equation in at least two different ways. The first is to blur the
distinction between server load and network proximity by monitoring
how long a server takes to respond to requests and using this
measurement as the “server load” parameter in the preceding
algorithm. This strategy tends to prefer nearby/lightly loaded servers
over distant/heavily loaded servers. A second approach is to factor
proximity into the decision at an earlier stage by limiting the
candidate set of servers considered by the above algorithms (*S*) to
only those that are nearby. The harder problem is deciding which of
the potentially many servers are suitably close. One approach would be
to select only those servers that are available on the same ISP as the
client. A slightly more sophisticated approach would be to look at the
map of autonomous systems produced by BGP and select only those
servers within some number of hops from the client as candidate
servers.  Finding the right balance between network proximity and
server cache locality is a subject of ongoing research.
