3.3 Internet (IP)
=================

In the previous section, we saw that it was possible to build reasonably
large LANs using bridges and LAN switches, but that such approaches were
limited in their ability to scale and to handle heterogeneity. In this
section, we explore some ways to go beyond the limitations of bridged
networks, enabling us to build large, highly heterogeneous networks with
reasonably efficient routing. We refer to such networks as
*internetworks.* We’ll continue the discussion of how to build a truly
global internetwork in the next chapter, but for now we’ll explore the
basics. We start by considering more carefully what the word
*internetwork* means.

What Is an Internetwork?
------------------------

We use the term *internetwork*, or sometimes just *internet* with a
lowercase *i*, to refer to an arbitrary collection of networks
interconnected to provide some sort of host-to-host packet delivery
service. For example, a corporation with many sites might construct a
private internetwork by interconnecting the LANs at their different
sites with point-to-point links leased from the phone company. When we
are talking about the widely used global internetwork to which a large
percentage of networks are now connected, we call it the *Internet* with
a capital *I.* In keeping with the first-principles approach of this
book, we mainly want you to learn about the principles of “lowercase
*i*” internetworking, but we illustrate these ideas with real-world
examples from the “big *I*” Internet.

Another piece of terminology that can be confusing is the difference
between networks, subnetworks, and internetworks. We are going to avoid
subnetworks (or subnets) altogether until a later section. For now,
we use *network* to mean either a directly connected or a switched
network of the kind described in the previous section and the previous
chapter. Such a network uses one technology, such as 802.11 or Ethernet.
An *internetwork* is an interconnected collection of such networks.
Sometimes, to avoid ambiguity, we refer to the underlying networks that
we are interconnecting as *physical* networks. An internet is a
*logical* network built out of a collection of physical networks. In
this context, a collection of Ethernet segments connected by bridges or
switches would still be viewed as a single network.

.. _fig-inet:
.. figure:: figures/f03-14-9780123850591.png
   :width: 500px
   :align: center

   A simple internetwork. H denotes a host and R denotes
   a router.

:numref:`Figure %s <fig-inet>` shows an example internetwork. An
internetwork is often referred to as a “network of networks” because
it is made up of lots of smaller networks. In this figure, we see
Ethernets, a wireless network, and a point-to-point link. Each of
these is a single-technology network. The nodes that interconnect the
networks are called *routers*.  They are also sometimes called
*gateways*, but since this term has several other connotations, we
restrict our usage to router.

.. _fig-ip-graph:
.. figure:: figures/f03-15-9780123850591.png
   :width: 600px
   :align: center

   A simple internetwork, showing the protocol layers
   used to connect H5 to H8 in the above figure. ETH is the protocol
   that runs over the Ethernet.

The *Internet Protocol* is the key tool used today to build scalable,
heterogeneous internetworks. It was originally known as the Kahn-Cerf
protocol after its inventors. One way to think of IP is that it runs on
all the nodes (both hosts and routers) in a collection of networks and
defines the infrastructure that allows these nodes and networks to
function as a single logical internetwork. For example, :numref:`Figure
%s <fig-ip-graph>` shows how hosts H5 and H8 are logically connected by
the internet in :numref:`Figure %s <fig-inet>`, including the protocol graph
running on each node. Note that higher-level protocols, such as TCP and
UDP, typically run on top of IP on the hosts.

The rest of this and the next chapter are about various aspects of IP.
While it is certainly possible to build an internetwork that does not
use IP—and in fact, in the early days of the Internet there were
alternative solutions—IP is the most interesting case to study simply
because of the size of the Internet. Said another way, it is only the IP
Internet that has really faced the issue of scale. Thus, it provides the
best case study of a scalable internetworking protocol.

.. sidebar:: L2 vs L3 Networks

   As seen in the previous section, an Ethernet can be treated as a
   point-to-point *link* interconnecting a pair of switches, with a
   mesh of interconnected switches forming a *Switched Ethernet*. This
   configuration is also known as an *L2 Network*.

   But as we'll discover in this section, an Ethernet (even when
   arranged in a point-to-point configuration rather than a shared
   CSMA/CD network) can be treated as a *network* interconnecting a
   pair of routers, with a mesh of such routers forming an Internet.
   This configuration is also known as an *L3 Network*.

   Confusingly, this is because a point-to-point Ethernet is both a
   link and a network (albeit a trivial two-node network in the second
   case), depending on whether it's connected to a pair of L2 switches
   running the spanning tree algorithm, or to a pair of L3 routers
   running IP (plus the routing protocols described later in this
   chapter). Why pick one configuration over the other? It partly
   depends on whether you want the network to be a single broadcast
   domain (if yes, pick L2), and whether you want the hosts connected
   to the network to be on different networks (if yes, select L3).

   The good news is that when you fully understand the implications of
   this duality, you will have cleared a major hurdle in mastering
   modern packet-switched networks.
	     
Service Model
-------------

A good place to start when you build an internetwork is to define its
*service model*, that is, the host-to-host services you want to provide.
The main concern in defining a service model for an internetwork is that
we can provide a host-to-host service only if this service can somehow
be provided over each of the underlying physical networks. For example,
it would be no good deciding that our internetwork service model was
going to provide guaranteed delivery of every packet in 1 ms or less if
there were underlying network technologies that could arbitrarily delay
packets. The philosophy used in defining the IP service model,
therefore, was to make it undemanding enough that just about any network
technology that might turn up in an internetwork would be able to
provide the necessary service.

The IP service model can be thought of as having two parts: an
addressing scheme, which provides a way to identify all hosts in the
internetwork, and a datagram (connectionless) model of data delivery.
This service model is sometimes called *best effort* because, although
IP makes every effort to deliver datagrams, it makes no guarantees. We
postpone a discussion of the addressing scheme for now and look first at
the data delivery model.

Datagram Delivery
~~~~~~~~~~~~~~~~~

The IP datagram is fundamental to the Internet Protocol. Recall from
an earlier section that a datagram is a packet sent in a
connectionless manner over a network. Every datagram carries enough
information to let the network forward the packet to its correct
destination; there is no need for any advance setup mechanism to tell
the network what to do when the packet arrives. You just send it, and
the network makes its best effort to get it to the desired
destination.  The “best-effort” part means that if something goes
wrong and the packet gets lost, corrupted, misdelivered, or in any way
fails to reach its intended destination, the network does nothing—it
made its best effort, and that is all it has to do. It does not make
any attempt to recover from the failure. This is sometimes called an
*unreliable* service.

Best-effort, connectionless service is about the simplest service you
could ask for from an internetwork, and this is its great strength. For
example, if you provide best-effort service over a network that provides
a reliable service, then that’s fine—you end up with a best-effort
service that just happens to always deliver the packets. If, on the
other hand, you had a reliable service model over an unreliable network,
you would have to put lots of extra functionality into the routers to
make up for the deficiencies of the underlying network. Keeping the
routers as simple as possible was one of the original design goals
of IP.

The ability of IP to “run over anything” is frequently cited as one of
its most important characteristics. It is noteworthy that many of the
technologies over which IP runs today did not exist when IP was
invented. So far, no networking technology has been invented that has
proven too bizarre for IP. In principle, IP can run over a network that
transports messages using carrier pigeons.

Best-effort delivery does not just mean that packets can get lost.
Sometimes they can get delivered out of order, and sometimes the same
packet can get delivered more than once. The higher-level protocols or
applications that run above IP need to be aware of all these possible
failure modes.

Packet Format
~~~~~~~~~~~~~

Clearly, a key part of the IP service model is the type of packets
that can be carried. The IP datagram, like most packets, consists of a
header followed by a number of bytes of data. The format of the header
is shown in :numref:`Figure %s <fig-iphead>`. Note that we have
adopted a different style of representing packets than the one we used
in previous chapters. This is because packet formats at the
internetworking layer and above, where we will be focusing our
attention for the next few chapters, are almost invariably designed to
align on 32-bit boundaries to simplify the task of processing them in
software. Thus, the common way of representing them (used in Internet
Requests for Comments, for example) is to draw them as a succession of
32-bit words. The top word is the one transmitted first, and the
leftmost byte of each word is the one transmitted first. In this
representation, you can easily recognize fields that are a multiple of
8 bits long. On the odd occasion when fields are not an even multiple
of 8 bits, you can determine the field lengths by looking at the bit
positions marked at the top of the packet.

.. _fig-iphead:
.. figure:: figures/f03-16-9780123850591.png
   :width: 450px
   :align: center

   IPv4 packet header.

Looking at each field in the IP header, we see that the “simple” model
of best-effort datagram delivery still has some subtle features. The
``Version`` field specifies the version of IP. The still-assumed version
of IP is 4, which is typically called *IPv4*. Observe that putting this
field right at the start of the datagram makes it easy for everything
else in the packet format to be redefined in subsequent versions; the
header processing software starts off by looking at the version and then
branches off to process the rest of the packet according to the
appropriate format. The next field, ``HLen``, specifies the length of
the header in 32-bit words. When there are no options, which is most of
the time, the header is 5 words (20 bytes) long. The 8-bit ``TOS`` (type
of service) field has had a number of different definitions over the
years, but its basic function is to allow packets to be treated
differently based on application needs. For example, the ``TOS`` value
might determine whether or not a packet should be placed in a special
queue that receives low delay.

The next 16 bits of the header contain the ``Length`` of the datagram,
including the header. Unlike the ``HLen`` field, the ``Length`` field
counts bytes rather than words. Thus, the maximum size of an IP datagram
is 65,535 bytes. The physical network over which IP is running, however,
may not support such long packets. For this reason, IP supports a
fragmentation and reassembly process. The second word of the header
contains information about fragmentation, and the details of its use are
presented in the following section entitled “Fragmentation and
Reassembly.”

Moving on to the third word of the header, the next byte is the ``TTL``
(time to live) field. Its name reflects its historical meaning rather
than the way it is commonly used today. The intent of the field is to
catch packets that have been going around in routing loops and discard
them, rather than let them consume resources indefinitely. Originally,
``TTL`` was set to a specific number of seconds that the packet would be
allowed to live, and routers along the path would decrement this field
until it reached 0. However, since it was rare for a packet to sit for
as long as 1 second in a router, and routers did not all have access to
a common clock, most routers just decremented the ``TTL`` by 1 as they
forwarded the packet. Thus, it became more of a hop count than a timer,
which is still a perfectly good way to catch packets that are stuck in
routing loops. One subtlety is in the initial setting of this field by
the sending host: Set it too high and packets could circulate rather a
lot before getting dropped; set it too low and they may not reach their
destination. The value 64 is the current default.

The ``Protocol`` field is simply a demultiplexing key that identifies
the higher-level protocol to which this IP packet should be passed.
There are values defined for the TCP (Transmission Control Protocol—6),
UDP (User Datagram Protocol—17), and many other protocols that may sit
above IP in the protocol graph.

The ``Checksum`` is calculated by considering the entire IP header as a
sequence of 16-bit words, adding them up using ones’ complement
arithmetic, and taking the ones’ complement of the result. Thus, if any
bit in the header is corrupted in transit, the checksum will not contain
the correct value upon receipt of the packet. Since a corrupted header
may contain an error in the destination address—and, as a result, may
have been misdelivered—it makes sense to discard any packet that fails
the checksum. It should be noted that this type of checksum does not
have the same strong error detection properties as a CRC, but it is much
easier to calculate in software.

The last two required fields in the header are the ``SourceAddr`` and
the ``DestinationAddr`` for the packet. The latter is the key to
datagram delivery: Every packet contains a full address for its intended
destination so that forwarding decisions can be made at each router. The
source address is required to allow recipients to decide if they want to
accept the packet and to enable them to reply. IP addresses are
discussed in a later section—for now, the important thing to know is
that IP defines its own global address space, independent of whatever
physical networks it runs over. As we will see, this is one of the keys
to supporting heterogeneity.

Finally, there may be a number of options at the end of the header. The
presence or absence of options may be determined by examining the header
length (``HLen``) field. While options are used fairly rarely, a
complete IP implementation must handle them all.

Fragmentation and Reassembly
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the problems of providing a uniform host-to-host service model
over a heterogeneous collection of networks is that each network
technology tends to have its own idea of how large a packet can be. For
example, classic Ethernet can accept packets up to 1500 bytes long, but
modern-day variants can deliver larger (jumbo) packets that carry up to
9000 bytes of payload. This leaves two choices for the IP service model:
Make sure that all IP datagrams are small enough to fit inside one
packet on any network technology, or provide a means by which packets
can be fragmented and reassembled when they are too big to go over a
given network technology. The latter turns out to be a good choice,
especially when you consider the fact that new network technologies are
always turning up, and IP needs to run over all of them; this would make
it hard to pick a suitably small bound on datagram size. This also means
that a host will not send needlessly small packets, which wastes
bandwidth and consumes processing resources by requiring more headers
per byte of data sent.

The central idea here is that every network type has a *maximum
transmission unit* (MTU), which is the largest IP datagram that it can
carry in a frame.\ [#]_ Note that this value is smaller than the largest
packet size on that network because the IP datagram needs to fit in the
*payload* of the link-layer frame.

.. [#] In ATM networks, the MTU is, fortunately, much larger than a
       single cell, as ATM has its own fragmentation and reassembly
       mechanism. The link-layer frame in ATM is called a
       *convergence-sublayer protocol data unit* (CS-PDU).

When a host sends an IP datagram, therefore, it can choose any size that
it wants. A reasonable choice is the MTU of the network to which the
host is directly attached. Then, fragmentation will only be necessary if
the path to the destination includes a network with a smaller MTU.
Should the transport protocol that sits on top of IP give IP a packet
larger than the local MTU, however, then the source host must
fragment it.

Fragmentation typically occurs in a router when it receives a datagram
that it wants to forward over a network that has an MTU that is smaller
than the received datagram. To enable these fragments to be reassembled
at the receiving host, they all carry the same identifier in the
``Ident`` field. This identifier is chosen by the sending host and is
intended to be unique among all the datagrams that might arrive at the
destination from this source over some reasonable time period. Since all
fragments of the original datagram contain this identifier, the
reassembling host will be able to recognize those fragments that go
together. Should all the fragments not arrive at the receiving host, the
host gives up on the reassembly process and discards the fragments that
did arrive. IP does not attempt to recover from missing fragments.
  
.. _fig-frag:
.. figure:: figures/f03-17-9780123850591.png
   :width: 600px
   :align: center

   IP datagrams traversing the sequence of physical 
   networks graphed in the earlier figure.

To see what this all means, consider what happens when host H5 sends a
datagram to host H8 in the example internet shown in :numref:`Figure
%s <fig-inet>`. Assuming that the MTU is 1500 bytes for the two
Ethernets and the 802.11 network, and 532 bytes for the point-to-point
network, then a 1420-byte datagram (20-byte IP header plus 1400 bytes
of data) sent from H5 makes it across the 802.11 network and the first
Ethernet without fragmentation but must be fragmented into three
datagrams at router R2. These three fragments are then forwarded by
router R3 across the second Ethernet to the destination host. This
situation is illustrated in :numref:`Figure %s <fig-frag>`. This
figure also serves to reinforce two important points:

1. Each fragment is itself a self-contained IP datagram that is
   transmitted over a sequence of physical networks, independent of the
   other fragments.

2. Each IP datagram is re-encapsulated for each physical network over
   which it travels.

.. _fig-fragment:
.. figure:: figures/f03-18-9780123850591.png
   :align: center
   :width: 350px

   Header fields used in IP fragmentation: 
   (a) unfragmented packet; (b) fragmented packets.

The fragmentation process can be understood in detail by looking at
the header fields of each datagram, as is done in :numref:`Figure %s
<fig-fragment>`.  The unfragmented packet, shown at the top, has
1400 bytes of data and a 20-byte IP header. When the packet arrives at
router R2, which has an MTU of 532 bytes, it has to be fragmented. A
532-byte MTU leaves 512 bytes for data after the 20-byte IP header, so
the first fragment contains 512 bytes of data. The router sets the M
bit in the ``Flags`` field (see :numref:`Figure %s <fig-iphead>`),
meaning that there are more fragments to follow, and it sets the
``Offset`` to 0, since this fragment contains the first part of the
original datagram. The data carried in the second fragment starts with
the 513th byte of the original data, so the ``Offset`` field in this
header is set to 64, which is 512/8. Why the division by 8? Because
the designers of IP decided that fragmentation should always happen on
8-byte boundaries, which means that the ``Offset`` field counts 8-byte
chunks, not bytes.  (We leave it as an exercise for you to figure out
why this design decision was made.) The third fragment contains the
last 376 bytes of data, and the offset is now 2 × 512/8 = 128. Since
this is the last fragment, the M bit is not set.

Observe that the fragmentation process is done in such a way that it
could be repeated if a fragment arrived at another network with an even
smaller MTU. Fragmentation produces smaller, valid IP datagrams that can
be readily reassembled into the original datagram upon receipt,
independent of the order of their arrival. Reassembly is done at the
receiving host and not at each router.

IP reassembly is far from a simple process. For example, if a single
fragment is lost, the receiver will still attempt to reassemble the
datagram, and it will eventually give up and have to garbage-collect the
resources that were used to perform the failed reassembly. Getting a
host to tie up resources needlessly can be the basis of a
denial-of-service attack.

For this reason, among others, IP fragmentation is generally considered
a good thing to avoid. Hosts are now strongly encouraged to perform
“path MTU discovery,” a process by which fragmentation is avoided by
sending packets that are small enough to traverse the link with the
smallest MTU in the path from sender to receiver.

Global Addresses
----------------

In the above discussion of the IP service model, we mentioned that one
of the things that it provides is an addressing scheme. After all, if
you want to be able to send data to any host on any network, there needs
to be a way of identifying all the hosts. Thus, we need a global
addressing scheme—one in which no two hosts have the same address.
Global uniqueness is the first property that should be provided in an
addressing scheme.

Ethernet addresses are globally unique, but that alone does not
suffice for an addressing scheme in a large internetwork. Ethernet
addresses are also *flat*, which means that they have no structure and
provide very few clues to routing protocols. (In fact, Ethernet
addresses do have a structure for the purposes of *assignment*—the
first 24 bits identify the manufacturer—but this provides no useful
information to routing protocols since this structure has nothing to
do with network topology.)  In contrast, IP addresses are
*hierarchical*, by which we mean that they are made up of several
parts that correspond to some sort of hierarchy in the
internetwork. Specifically, IP addresses consist of two parts, usually
referred to as a *network* part and a *host* part. This is a fairly
logical structure for an internetwork, which is made up of many
interconnected networks. The network part of an IP address identifies
the network to which the host is attached; all hosts attached to the
same network have the same network part in their IP address. The host
part then identifies each host uniquely on that particular network.
Thus, in the simple internetwork of :numref:`Figure %s <fig-inet>`,
the addresses of the hosts on network 1, for example, would all have
the same network part and different host parts.

Note that the routers in :numref:`Figure %s <fig-inet>` are attached to two
networks. They need to have an address on each network, one for each
interface. For example, router R1, which sits between the wireless
network and an Ethernet, has an IP address on the interface to the
wireless network whose network part is the same as all the hosts on that
network. It also has an IP address on the interface to the Ethernet that
has the same network part as the hosts on that Ethernet. Thus, bearing
in mind that a router might be implemented as a host with two network
interfaces, it is more precise to think of IP addresses as belonging to
interfaces than to hosts.

Now, what do these hierarchical addresses look like? Unlike some other
forms of hierarchical address, the sizes of the two parts are not the
same for all addresses. Originally, IP addresses were divided into
three different classes, as shown in :numref:`Figure %s <fig-class>`,
each of which defines different-sized network and host parts. (There
are also class D addresses that specify a multicast group and class E
addresses that are currently unused.) In all cases, the address is
32 bits long.

The class of an IP address is identified in the most significant few
bits. If the first bit is 0, it is a class A address. If the first bit
is 1 and the second is 0, it is a class B address. If the first two
bits are 1 and the third is 0, it is a class C address. Thus, of the
approximately 4 billion possible IP addresses, half are class A,
one-quarter are class B, and one-eighth are class C. Each class
allocates a certain number of bits for the network part of the address
and the rest for the host part. Class A networks have 7 bits for the
network part and 24 bits for the host part, meaning that there can be
only 126 class A networks (the values 0 and 127 are reserved), but
each of them can accommodate up to :math:`2^{24} - 2` (about
16 million) hosts (again, there are two reserved values).  Class B
addresses allocate 14 bits for the network and 16 bits for the host,
meaning that each class B network has room for 65,534 hosts.  Finally,
class C addresses have only 8 bits for the host and 21 for the network
part. Therefore, a class C network can have only 256 unique host
identifiers, which means only 254 attached hosts (one host identifier,
255, is reserved for broadcast, and 0 is not a valid host number).
However, the addressing scheme supports 2\ :sup:`21` class C networks.
 
.. _fig-class:
.. figure:: figures/f03-19-9780123850591.png
   :width: 350px
   :align: center

   IP addresses: (a) class A; (b) class B; (c) class C.

On the face of it, this addressing scheme has a lot of flexibility,
allowing networks of vastly different sizes to be accommodated fairly
efficiently. The original idea was that the Internet would consist of a
small number of wide area networks (these would be class A networks), a
modest number of site- (campus-) sized networks (these would be class B
networks), and a large number of LANs (these would be class C networks).
However, it turned out not to be flexible enough, as we will see in a
moment. Today, IP addresses are normally “classless”; the details of
this are explained below.

Before we look at how IP addresses get used, it is helpful to look at
some practical matters, such as how you write them down. By convention,
IP addresses are written as four *decimal* integers separated by dots.
Each integer represents the decimal value contained in 1 byte of the
address, starting at the most significant. For example, the address of
the computer on which this sentence was typed is ``171.69.210.245``.

It is important not to confuse IP addresses with Internet domain names,
which are also hierarchical. Domain names tend to be ASCII strings
separated by dots, such as ``cs.princeton.edu``. The important thing
about IP addresses is that they are what is carried in the headers of IP
packets, and it is those addresses that are used in IP routers to make
forwarding decisions.

Datagram Forwarding in IP
-------------------------

We are now ready to look at the basic mechanism by which IP routers
forward datagrams in an internetwork. Recall from an earlier section
that *forwarding* is the process of taking a packet from an input and
sending it out on the appropriate output, while *routing* is the process
of building up the tables that allow the correct output for a packet to
be determined. The discussion here focuses on forwarding; we take up
routing in a later section.

The main points to bear in mind as we discuss the forwarding of IP
datagrams are the following:

-  Every IP datagram contains the IP address of the destination host.

-  The network part of an IP address uniquely identifies a single
   physical network that is part of the larger Internet.

-  All hosts and routers that share the same network part of their
   address are connected to the same physical network and can thus
   communicate with each other by sending frames over that network.

-  Every physical network that is part of the Internet has at least one
   router that, by definition, is also connected to at least one other
   physical network; this router can exchange packets with hosts or
   routers on either network.

Forwarding IP datagrams can therefore be handled in the following way. A
datagram is sent from a source host to a destination host, possibly
passing through several routers along the way. Any node, whether it is a
host or a router, first tries to establish whether it is connected to
the same physical network as the destination. To do this, it compares
the network part of the destination address with the network part of the
address of each of its network interfaces. (Hosts normally have only one
interface, while routers normally have two or more, since they are
typically connected to two or more networks.) If a match occurs, then
that means that the destination lies on the same physical network as the
interface, and the packet can be directly delivered over that network. A
later section explains some of the details of this process.

If the node is not connected to the same physical network as the
destination node, then it needs to send the datagram to a router. In
general, each node will have a choice of several routers, and so it
needs to pick the best one, or at least one that has a reasonable chance
of getting the datagram closer to its destination. The router that it
chooses is known as the *next hop* router. The router finds the correct
next hop by consulting its forwarding table. The forwarding table is
conceptually just a list of ``(NetworkNum, NextHop)``\ pairs. (As we
will see below, forwarding tables in practice often contain some
additional information related to the next hop.) Normally, there is also
a default router that is used if none of the entries in the table
matches the destination’s network number. For a host, it may be quite
acceptable to have a default router and nothing else—this means that all
datagrams destined for hosts not on the physical network to which the
sending host is attached will be sent out through the default router.

We can describe the datagram forwarding algorithm in the following way:

::

   if (NetworkNum of destination = NetworkNum of one of my interfaces) then
       deliver packet to destination over that interface
   else
       if (NetworkNum of destination is in my forwarding table) then
           deliver packet to NextHop router
       else
           deliver packet to default router

For a host with only one interface and only a default router in its
forwarding table, this simplifies to

::

   if (NetworkNum of destination = my NetworkNum) then
       deliver packet to destination directly
   else
       deliver packet to default router

Let’s see how this works in the example internetwork of :numref:`Figure
%s <fig-inet>`. First, suppose that H1 wants to send a datagram to H2.
Since they are on the same physical network, H1 and H2 have the same
network number in their IP address. Thus, H1 deduces that it can deliver
the datagram directly to H2 over the Ethernet. The one issue that needs
to be resolved is how H1 finds out the correct Ethernet address for
H2—the resolution mechanism described in a later section addresses this
issue.

Now suppose H5 wants to send a datagram to H8. Since these hosts are
on different physical networks, they have different network numbers,
so H5 deduces that it needs to send the datagram to a router. R1 is
the only choice—the default router—so H1 sends the datagram over the
wireless network to R1. Similarly, R1 knows that it cannot deliver a
datagram directly to H8 because neither of R1’s interfaces are on the
same network as H8. Suppose R1’s default router is R2; R1 then sends
the datagram to R2 over the Ethernet. Assuming R2 has the forwarding
table shown in :numref:`Table %s <tab-ipfwdtab>`, it looks up H8’s
network number (network 4) and forwards the datagram over the
point-to-point network to R3. Finally, R3, since it is on the same
network as H8, forwards the datagram directly to H8.
 
.. _tab-ipfwdtab:
.. table:: Forwarding table for Router R2.
   :align: center
   :widths: auto

   +------------+---------+
   | NetworkNum | NextHop |
   +============+=========+
   | 1          | R1      |
   +------------+---------+
   | 4          | R3      |
   +------------+---------+

Note that it is possible to include the information about directly 
connected networks in the forwarding table. For example, we could label 
the network interfaces of router R2 as interface 0 for the 
point-to-point link (network 3) and interface 1 for the Ethernet 
(network 2). Then R2 would have the forwarding table shown 
in :numref:`Table %s <tab-ipfwdtab2>`. 

.. _tab-ipfwdtab2:
.. table:: Complete Forwarding table for Router R2.
   :align: center
   :widths: auto

   +------------+-------------+
   | NetworkNum | NextHop     |
   +============+=============+
   | 1          | R1          |
   +------------+-------------+
   | 2          | Interface 1 |
   +------------+-------------+
   | 3          | Interface 0 |
   +------------+-------------+
   | 4          | R3          |
   +------------+-------------+

Thus, for any network number that R2 encounters in a packet, it knows
what to do. Either that network is directly connected to R2, in which
case the packet can be delivered to its destination over that network,
or the network is reachable via some next hop router that R2 can reach
over a network to which it is connected. In either case, R2 will use
ARP, described below, to find the MAC address of the node to which the
packet is to be sent next.

The forwarding table used by R2 is simple enough that it could be
manually configured. Usually, however, these tables are more complex and
would be built up by running a routing protocol such as one of those
described in a later section. Also note that, in practice, the network
numbers are usually longer (e.g., 128.96).

We can now see how hierarchical addressing—splitting the address into
network and host parts—has improved the scalability of a large network.
Routers now contain forwarding tables that list only a set of network
numbers rather than all the nodes in the network. In our simple example,
that meant that R2 could store the information needed to reach all the
hosts in the network (of which there were eight) in a four-entry table.
Even if there were 100 hosts on each physical network, R2 would still
only need those same four entries. This is a good first step (although
by no means the last) in achieving scalability.

.. _key-aggregation:
.. admonition:: Key Takeaway

   This illustrates one of the most important principles of building
   scalable networks: To achieve scalability, you need to reduce the
   amount of information that is stored in each node and that is
   exchanged between nodes. The most common way to do that is
   *hierarchical aggregation*. IP introduces a two-level hierarchy, with
   networks at the top level and nodes at the bottom level. We have
   aggregated information by letting routers deal only with reaching the
   right network; the information that a router needs to deliver a
   datagram to any node on a given network is represented by a single
   aggregated piece of information. :ref:`[Next] <key-best-effort>`

Subnetting and Classless Addressing
-----------------------------------

The original intent of IP addresses was that the network part would
uniquely identify exactly one physical network. It turns out that this
approach has a couple of drawbacks. Imagine a large campus that has lots
of internal networks and decides to connect to the Internet. For every
network, no matter how small, the site needs at least a class C network
address. Even worse, for any network with more than 255 hosts, they need
a class B address. This may not seem like a big deal, and indeed it
wasn’t when the Internet was first envisioned, but there are only a
finite number of network numbers, and there are far fewer class B
addresses than class Cs. Class B addresses tend to be in particularly
high demand because you never know if your network might expand beyond
255 nodes, so it is easier to use a class B address from the start than
to have to renumber every host when you run out of room on a class C
network. The problem we observe here is address assignment inefficiency:
A network with two nodes uses an entire class C network address, thereby
wasting 253 perfectly useful addresses; a class B network with slightly
more than 255 hosts wastes over 64,000 addresses.

Assigning one network number per physical network, therefore, uses up
the IP address space potentially much faster than we would like. While
we would need to connect over 4 billion hosts to use up all the valid
addresses, we only need to connect 2\ :sup:`14` (about 16,000) class B 
networks before that part of the address space
runs out. Therefore, we would like to find some way to use the network
numbers more efficiently.

Assigning many network numbers has another drawback that becomes
apparent when you think about routing. Recall that the amount of state
that is stored in a node participating in a routing protocol is
proportional to the number of other nodes, and that routing in an
internet consists of building up forwarding tables that tell a router
how to reach different networks. Thus, the more network numbers there
are in use, the bigger the forwarding tables get. Big forwarding tables
add costs to routers, and they are potentially slower to search than
smaller tables for a given technology, so they degrade router
performance. This provides another motivation for assigning network
numbers carefully.

*Subnetting* provides a first step to reducing total number of network
numbers that are assigned. The idea is to take a single IP network
number and allocate the IP addresses with that network number to several
physical networks, which are now referred to as *subnets*. Several
things need to be done to make this work. First, the subnets should be
close to each other. This is because from a distant point in the
Internet, they will all look like a single network, having only one
network number between them. This means that a router will only be able
to select one route to reach any of the subnets, so they had better all
be in the same general direction. A perfect situation in which to use
subnetting is a large campus or corporation that has many physical
networks. From outside the campus, all you need to know to reach any
subnet inside the campus is where the campus connects to the rest of the
Internet. This is often at a single point, so one entry in your
forwarding table will suffice. Even if there are multiple points at
which the campus is connected to the rest of the Internet, knowing how
to get to one point in the campus network is still a good start.

The mechanism by which a single network number can be shared among
multiple networks involves configuring all the nodes on each subnet with
a *subnet mask*. With simple IP addresses, all hosts on the same network
must have the same network number. The subnet mask enables us to
introduce a *subnet number*; all hosts on the same physical network will
have the same subnet number, which means that hosts may be on different
physical networks but share a single network number. This concept is
illustrated in :numref:`Figure %s <fig-subaddr>`.
  
.. _fig-subaddr:
.. figure:: figures/f03-20-9780123850591.png
   :width: 350px
   :align: center

   Subnet addressing.

What subnetting means to a host is that it is now configured with both
an IP address and a subnet mask for the subnet to which it is
attached.  For example, host H1 in :numref:`Figure %s <fig-subnet>` is
configured with an address of 128.96.34.15 and a subnet mask of
255.255.255.128. (All hosts on a given subnet are configured with the
same mask; that is, there is exactly one subnet mask per subnet.) The
bitwise AND of these two numbers defines the subnet number of the host
and of all other hosts on the same subnet. In this case, 128.96.34.15
AND 255.255.255.128 equals 128.96.34.0, so this is the subnet number
for the topmost subnet in the figure.
 
.. _fig-subnet:
.. figure:: figures/f03-21-9780123850591.png
   :width: 500px
   :align: center

   An example of subnetting.

When the host wants to send a packet to a certain IP address, the first
thing it does is to perform a bitwise AND between its own subnet mask
and the destination IP address. If the result equals the subnet number
of the sending host, then it knows that the destination host is on the
same subnet and the packet can be delivered directly over the subnet. If
the results are not equal, the packet needs to be sent to a router to be
forwarded to another subnet. For example, if H1 is sending to H2, then
H1 ANDs its subnet mask (255.255.255.128) with the address for H2
(128.96.34.139) to obtain 128.96.34.128. This does not match the subnet
number for H1 (128.96.34.0) so H1 knows that H2 is on a different
subnet. Since H1 cannot deliver the packet to H2 directly over the
subnet, it sends the packet to its default router R1.

The forwarding table of a router also changes slightly when we introduce
subnetting. Recall that we previously had a forwarding table that
consisted of entries of the form ``(NetworkNum, NextHop)``. To support
subnetting, the table must now hold entries of the form
``(SubnetNumber, SubnetMask, NextHop)``. To find the right entry in the
table, the router ANDs the packet’s destination address with the
``SubnetMask``\ for each entry in turn; if the result matches the
``SubnetNumber`` of the entry, then this is the right entry to use, and
it forwards the packet to the next hop router indicated. In the example
network of :numref:`Figure %s <fig-subnet>`, router R1 would have the entries
shown in :numref:`Table %s <tab-subnettab>`.

.. _tab-subnettab:
.. table:: Example Forwarding Table with Subnetting.
   :align: center
   :widths: auto

   +---------------+-----------------+-------------+
   | SubnetNumber  | SubnetMask      | NextHop     |
   +===============+=================+=============+
   | 128.96.34.0   | 255.255.255.128 | Interface 0 |
   +---------------+-----------------+-------------+
   | 128.96.34.128 | 255.255.255.128 | Interface 1 |
   +---------------+-----------------+-------------+
   | 128.96.33.0   | 255.255.255.0   | R2          |
   +---------------+-----------------+-------------+

Continuing with the example of a datagram from H1 being sent to H2, R1
would AND H2’s address (128.96.34.139) with the subnet mask of the first
entry (255.255.255.128) and compare the result (128.96.34.128) with the
network number for that entry (128.96.34.0). Since this is not a match,
it proceeds to the next entry. This time a match does occur, so R1
delivers the datagram to H2 using interface 1, which is the interface
connected to the same network as H2.

We can now describe the datagram forwarding algorithm in the following
way:

::

   D = destination IP address
   for each forwarding table entry (SubnetNumber, SubnetMask, NextHop)
       D1 = SubnetMask & D
       if D1 = SubnetNumber
           if NextHop is an interface
               deliver datagram directly to destination
           else
               deliver datagram to NextHop (a router)

Although not shown in this example, a default route would usually be
included in the table and would be used if no explicit matches were
found. Note that a naive implementation of this algorithm—one involving
repeated ANDing of the destination address with a subnet mask that may
not be different every time, and a linear table search—would be very
inefficient.

An important consequence of subnetting is that different parts of the
internet see the world differently. From outside our hypothetical
campus, routers see a single network. In the example above, routers
outside the campus see the collection of networks in :numref:`Figure
%s <fig-subnet>` as just the network 128.96, and they keep one entry in
their forwarding tables to tell them how to reach it. Routers within the
campus, however, need to be able to route packets to the right subnet.
Thus, not all parts of the internet see exactly the same routing
information. This is an example of an *aggregation* of routing
information, which is fundamental to scaling of the routing system. The
next section shows how aggregation can be taken to another level.

Classless Addressing
~~~~~~~~~~~~~~~~~~~~

Subnetting has a counterpart, sometimes called *supernetting*, but more
often called *Classless Interdomain Routing* or CIDR, pronounced
“cider.” CIDR takes the subnetting idea to its logical conclusion by
essentially doing away with address classes altogether. Why isn’t
subnetting alone sufficient? In essence, subnetting only allows us to
split a classful address among multiple subnets, while CIDR allows us to
coalesce several classful addresses into a single “supernet.” This
further tackles the address space inefficiency noted above, and does so
in a way that keeps the routing system from being overloaded.

To see how the issues of address space efficiency and scalability of the
routing system are coupled, consider the hypothetical case of a company
whose network has 256 hosts on it. That is slightly too many for a Class
C address, so you would be tempted to assign a class B. However, using
up a chunk of address space that could address 65535 to address 256
hosts has an efficiency of only 256/65,535 = 0.39%. Even though
subnetting can help us to assign addresses carefully, it does not get
around the fact that any organization with more than 255 hosts, or an
expectation of eventually having that many, wants a class B address.

The first way you might deal with this issue would be to refuse to give
a class B address to any organization that requests one unless they can
show a need for something close to 64K addresses, and instead giving
them an appropriate number of class C addresses to cover the expected
number of hosts. Since we would now be handing out address space in
chunks of 256 addresses at a time, we could more accurately match the
amount of address space consumed to the size of the organization. For
any organization with at least 256 hosts, we can guarantee an address
utilization of at least 50%, and typically much more. (Sadly, even if
you can justify a request of a class B network number, don’t bother,
because they were all spoken for long ago.)

This solution, however, raises a problem that is at least as serious:
excessive storage requirements at the routers. If a single site has,
say, 16 class C network numbers assigned to it, that means every
Internet backbone router needs 16 entries in its routing tables to
direct packets to that site. This is true even if the path to every one
of those networks is the same. If we had assigned a class B address to
the site, the same routing information could be stored in one table
entry. However, our address assignment efficiency would then be only 16 x
255 / 65,536 = 6.2%.

CIDR, therefore, tries to balance the desire to minimize the number of
routes that a router needs to know against the need to hand out
addresses efficiently. To do this, CIDR helps us to *aggregate* routes.
That is, it lets us use a single entry in a forwarding table to tell us
how to reach a lot of different networks. As noted above it does this by
breaking the rigid boundaries between address classes. To understand how
this works, consider our hypothetical organization with 16 class C
network numbers. Instead of handing out 16 addresses at random, we can
hand out a block of *contiguous* class C addresses. Suppose we assign
the class C network numbers from 192.4.16 through 192.4.31. Observe that
the top 20 bits of all the addresses in this range are the same
(``11000000 00000100 0001``). Thus, what we have effectively created is
a 20-bit network number—something that is between a class B network
number and a class C number in terms of the number of hosts that it can
support. In other words, we get both the high address efficiency of
handing out addresses in chunks smaller than a class B network, and a
single network prefix that can be used in forwarding tables. Observe
that, for this scheme to work, we need to hand out blocks of class C
addresses that share a common prefix, which means that each block must
contain a number of class C networks that is a power of two.

CIDR requires a new type of notation to represent network numbers, or
*prefixes* as they are known, because the prefixes can be of any length.
The convention is to place a ``/X`` after the prefix, where ``X`` is the
prefix length in bits. So, for the example above, the 20-bit prefix for
all the networks 192.4.16 through 192.4.31 is represented as
192.4.16/20. By contrast, if we wanted to represent a single class C
network number, which is 24 bits long, we would write it 192.4.16/24.
Today, with CIDR being the norm, it is more common to hear people talk
about “slash 24” prefixes than class C networks. Note that representing
a network address in this way is similar to the\ ``(mask, value)``
approach used in subnetting, as long as ``masks`` consist of contiguous
bits starting from the most significant bit (which in practice is almost
always the case).

.. _fig-cidreg:
.. figure:: figures/f03-22-9780123850591.png
   :width: 500px
   :align: center

   Route aggregation with CIDR.

The ability to aggregate routes at the edge of the network as we have
just seen is only the first step. Imagine an Internet service provider
network, whose primary job is to provide Internet connectivity to a
large number of corporations and campuses (customers). If we assign
prefixes to the customers in such a way that many different customer
networks connected to the provider network share a common, shorter
address prefix, then we can get even greater aggregation of routes.
Consider the example in :numref:`Figure %s <fig-cidreg>`. Assume that eight
customers served by the provider network have each been assigned
adjacent 24-bit network prefixes. Those prefixes all start with the same
21 bits. Since all of the customers are reachable through the same
provider network, it can advertise a single route to all of them by just
advertising the common 21-bit prefix they share. And it can do this even
if not all the 24-bit prefixes have been handed out, as long as the
provider ultimately *will* have the right to hand out those prefixes to
a customer. One way to accomplish that is to assign a portion of address
space to the provider in advance and then to let the network provider
assign addresses from that space to its customers as needed. Note that,
in contrast to this simple example, there is no need for all customer
prefixes to be the same length.

IP Forwarding Revisited
~~~~~~~~~~~~~~~~~~~~~~~

In all our discussion of IP forwarding so far, we have assumed that we
could find the network number in a packet and then look up that number
in a forwarding table. However, now that we have introduced CIDR, we
need to reexamine this assumption. CIDR means that prefixes may be of
any length, from 2 to 32 bits. Furthermore, it is sometimes possible to
have prefixes in the forwarding table that “overlap,” in the sense that
some addresses may match more than one prefix. For example, we might
find both 171.69 (a 16-bit prefix) and 171.69.10 (a 24-bit prefix) in
the forwarding table of a single router. In this case, a packet destined
to, say, 171.69.10.5 clearly matches both prefixes. The rule in this
case is based on the principle of “longest match”; that is, the packet
matches the longest prefix, which would be 171.69.10 in this example. On
the other hand, a packet destined to 171.69.20.5 would match 171.69 and
*not* 171.69.10, and in the absence of any other matching entry in the
routing table 171.69 would be the longest match.

The task of efficiently finding the longest match between an IP address
and the variable-length prefixes in a forwarding table has been a
fruitful field of research for many years. The most well-known algorithm
uses an approach known as a *PATRICIA tree*, which was actually
developed well in advance of CIDR.

Address Translation (ARP)
-------------------------

In the previous section we talked about how to get IP datagrams to the
right physical network but glossed over the issue of how to get a
datagram to a particular host or router on that network. The main issue
is that IP datagrams contain IP addresses, but the physical interface
hardware on the host or router to which you want to send the datagram
only understands the addressing scheme of that particular network. Thus,
we need to translate the IP address to a link-level address that makes
sense on this network (e.g., a 48-bit Ethernet address). We can then
encapsulate the IP datagram inside a frame that contains that link-level
address and send it either to the ultimate destination or to a router
that promises to forward the datagram toward the ultimate destination.

One simple way to map an IP address into a physical network address is
to encode a host’s physical address in the host part of its IP address.
For example, a host with physical address ``00100001 01001001`` (which
has the decimal value 33 in the upper byte and 81 in the lower byte)
might be given the IP address ``128.96.33.81``. While this solution has
been used on some networks, it is limited in that the network’s physical
addresses can be no more than 16 bits long in this example; they can be
only 8 bits long on a class C network. This clearly will not work for
48-bit Ethernet addresses.

A more general solution would be for each host to maintain a table of
address pairs; that is, the table would map IP addresses into physical
addresses. While this table could be centrally managed by a system
administrator and then copied to each host on the network, a better
approach would be for each host to dynamically learn the contents of the
table using the network. This can be accomplished using the Address
Resolution Protocol (ARP). The goal of ARP is to enable each host on a
network to build up a table of mappings between IP addresses and
link-level addresses. Since these mappings may change over time (e.g.,
because an Ethernet card in a host breaks and is replaced by a new one
with a new address), the entries are timed out periodically and removed.
This happens on the order of every 15 minutes. The set of mappings
currently stored in a host is known as the ARP cache or ARP table.

ARP takes advantage of the fact that many link-level network
technologies, such as Ethernet, support broadcast. If a host wants to
send an IP datagram to a host (or router) that it knows to be on the
same network (i.e., the sending and receiving nodes have the same IP
network number), it first checks for a mapping in the cache. If no
mapping is found, it needs to invoke the Address Resolution Protocol
over the network. It does this by broadcasting an ARP query onto the
network. This query contains the IP address in question (the target IP
address). Each host receives the query and checks to see if it matches
its IP address. If it does match, the host sends a response message that
contains its link-layer address back to the originator of the query. The
originator adds the information contained in this response to its ARP
table.

The query message also includes the IP address and link-layer address of
the sending host. Thus, when a host broadcasts a query message, each
host on the network can learn the sender’s link-level and IP addresses
and place that information in its ARP table. However, not every host
adds this information to its ARP table. If the host already has an entry
for that host in its table, it “refreshes” this entry; that is, it
resets the length of time until it discards the entry. If that host is
the target of the query, then it adds the information about the sender
to its table, even if it did not already have an entry for that host.
This is because there is a good chance that the source host is about to
send it an application-level message, and it may eventually have to send
a response or ACK back to the source; it will need the source’s physical
address to do this. If a host is not the target and does not already
have an entry for the source in its ARP table, then it does not add an
entry for the source. This is because there is no reason to believe that
this host will ever need the source’s link-level address; there is no
need to clutter its ARP table with this information.

.. _fig-arp:
.. figure:: figures/f03-23-9780123850591.png
   :width: 500px
   :align: center

   ARP packet format for mapping IP addresses into Ethernet addresses.

:numref:`Figure %s <fig-arp>` shows the ARP packet format for
IP-to-Ethernet address mappings. In fact, ARP can be used for lots of
other kinds of mappings—the major differences are in the address
sizes. In addition to the IP and link-layer addresses of both sender
and target, the packet contains

-  A ``HardwareType`` field, which specifies the type of physical
   network (e.g., Ethernet)

-  A ``ProtocolType`` field, which specifies the higher-layer protocol
   (e.g., IP)

-  ``HLen`` (“hardware” address length) and ``PLen`` (“protocol” address
   length) fields, which specify the length of the link-layer address
   and higher-layer protocol address, respectively

-  An ``Operation`` field, which specifies whether this is a request or
   a response

-  The source and target hardware (Ethernet) and protocol (IP) addresses

Note that the results of the ARP process can be added as an extra column
in a forwarding table like the one in :numref:`Table %s <tab-ipfwdtab>`.
Thus, for example, when R2 needs to forward a packet to network 2, it
not only finds that the next hop is R1, but also finds the MAC address
to place on the packet to send it to R1.

.. _key-best-effort:
.. admonition:: Key Takeaway

   We have now seen the basic mechanisms that IP provides for dealing
   with both heterogeneity and scale. On the issue of heterogeneity, IP
   begins by defining a best-effort service model that makes minimal
   assumptions about the underlying networks; most notably, this service
   model is based on unreliable datagrams. IP then makes two important
   additions to this starting point: (1) a common packet format
   (fragmentation/reassembly is the mechanism that makes this format
   work over networks with different MTUs) and (2) a global address
   space for identifying all hosts (ARP is the mechanism that makes this
   global address space work over networks with different physical
   addressing schemes). On the issue of scale, IP uses hierarchical
   aggregation to reduce the amount of information needed to forward
   packets. Specifically, IP addresses are partitioned into network and
   host components, with packets first routed toward the destination
   network and then delivered to the correct host on that network.
   :ref:`[Next] <key-dhcp>`

Host Configuration (DHCP)
-------------------------

Ethernet addresses are configured into the network adaptor by the
manufacturer, and this process is managed in such a way to ensure that
these addresses are globally unique. This is clearly a sufficient
condition to ensure that any collection of hosts connected to a single
Ethernet (including an extended LAN) will have unique addresses.
Furthermore, uniqueness is all we ask of Ethernet addresses.

IP addresses, by contrast, not only must be unique on a given
internetwork but also must reflect the structure of the internetwork. As
noted above, they contain a network part and a host part, and the
network part must be the same for all hosts on the same network. Thus,
it is not possible for the IP address to be configured once into a host
when it is manufactured, since that would imply that the manufacturer
knew which hosts were going to end up on which networks, and it would
mean that a host, once connected to one network, could never move to
another. For this reason, IP addresses need to be reconfigurable.

In addition to an IP address, there are some other pieces of information
a host needs to have before it can start sending packets. The most
notable of these is the address of a default router—the place to which
it can send packets whose destination address is not on the same network
as the sending host.

Most host operating systems provide a way for a system administrator, or
even a user, to manually configure the IP information needed by a host;
however, there are some obvious drawbacks to such manual configuration.
One is that it is simply a lot of work to configure all the hosts in a
large network directly, especially when you consider that such hosts are
not reachable over a network until they are configured. Even more
importantly, the configuration process is very error prone, since it is
necessary to ensure that every host gets the correct network number and
that no two hosts receive the same IP address. For these reasons,
automated configuration methods are required. The primary method uses a
protocol known as the *Dynamic Host Configuration Protocol* (DHCP).

DHCP relies on the existence of a DHCP server that is responsible for
providing configuration information to hosts. There is at least one DHCP
server for an administrative domain. At the simplest level, the DHCP
server can function just as a centralized repository for host
configuration information. Consider, for example, the problem of
administering addresses in the internetwork of a large company. DHCP
saves the network administrators from having to walk around to every
host in the company with a list of addresses and network map in hand and
configuring each host manually. Instead, the configuration information
for each host could be stored in the DHCP server and automatically
retrieved by each host when it is booted or connected to the network.
However, the administrator would still pick the address that each host
is to receive; he would just store that in the server. In this model,
the configuration information for each host is stored in a table that is
indexed by some form of unique client identifier, typically the hardware
address (e.g., the Ethernet address of its network adaptor).

A more sophisticated use of DHCP saves the network administrator from
even having to assign addresses to individual hosts. In this model, the
DHCP server maintains a pool of available addresses that it hands out to
hosts on demand. This considerably reduces the amount of configuration
an administrator must do, since now it is only necessary to allocate a
range of IP addresses (all with the same network number) to each
network.

Since the goal of DHCP is to minimize the amount of manual configuration
required for a host to function, it would rather defeat the purpose if
each host had to be configured with the address of a DHCP server. Thus,
the first problem faced by DHCP is that of server discovery.

To contact a DHCP server, a newly booted or attached host sends a
``DHCPDISCOVER`` message to a special IP address (255.255.255.255) that
is an IP broadcast address. This means it will be received by all hosts
and routers on that network. (Routers do not forward such packets onto
other networks, preventing broadcast to the entire Internet.) In the
simplest case, one of these nodes is the DHCP server for the network.
The server would then reply to the host that generated the discovery
message (all the other nodes would ignore it). However, it is not really
desirable to require one DHCP server on every network, because this
still creates a potentially large number of servers that need to be
correctly and consistently configured. Thus, DHCP uses the concept of a
*relay agent*. There is at least one relay agent on each network, and it
is configured with just one piece of information: the IP address of the
DHCP server. When a relay agent receives a ``DHCPDISCOVER`` message, it
unicasts it to the DHCP server and awaits the response, which it will
then send back to the requesting client. The process of relaying a
message from a host to a remote DHCP server is shown in :numref:`Figure
%s <fig-dhcp-relay>`.
  
.. _fig-dhcp-relay:
.. figure:: figures/f03-24-9780123850591.png
   :width: 500px
   :align: center

   A DHCP relay agent receives a broadcast DHCPDISCOVER
   message from a host and sends a unicast DHCPDISCOVER to the DHCP
   server.

:numref:`Figure %s <fig-dhcp>` below shows the format of a DHCP
message. The message is actually sent using a protocol called the
*User Datagram Protocol* (UDP) that runs over IP. UDP is discussed in
detail in the next chapter, but the only interesting thing it does in
this context is to provide a demultiplexing key that says, “This is a
DHCP packet.”
 
.. _fig-dhcp:
.. figure:: figures/f03-25-9780123850591.png
   :width: 400px
   :align: center

   DHCP packet format.

DHCP is derived from an earlier protocol called BOOTP, and some of the
packet fields are thus not strictly relevant to host configuration. When
trying to obtain configuration information, the client puts its hardware
address (e.g., its Ethernet address) in the ``chaddr`` field. The DHCP
server replies by filling in the ``yiaddr`` (“your” IP address) field
and sending it to the client. Other information such as the default
router to be used by this client can be included in the ``options``
field.

In the case where DHCP dynamically assigns IP addresses to hosts, it is
clear that hosts cannot keep addresses indefinitely, as this would
eventually cause the server to exhaust its address pool. At the same
time, a host cannot be depended upon to give back its address, since it
might have crashed, been unplugged from the network, or been turned off.
Thus, DHCP allows addresses to be leased for some period of time. Once
the lease expires, the server is free to return that address to its
pool. A host with a leased address clearly needs to renew the lease
periodically if in fact it is still connected to the network and
functioning correctly.

.. _key-dhcp:
.. admonition:: Key Takeaway

   DHCP illustrates an important aspect of scaling: the scaling of
   network management. While discussions of scaling often focus on
   keeping the state in network devices from growing too fast, it is
   important to pay attention to the growth of network management
   complexity. By allowing network managers to configure a range of IP
   addresses per network rather than one IP address per host, DHCP
   improves the manageability of a network. :ref:`[Next] <key-forwarding>`

Note that DHCP may also introduce some more complexity into network
management, since it makes the binding between physical hosts and IP
addresses much more dynamic. This may make the network manager’s job
more difficult if, for example, it becomes necessary to locate a
malfunctioning host.

Error Reporting (ICMP)
----------------------

The next issue is how the Internet treats errors. While IP is perfectly
willing to drop datagrams when the going gets tough—for example, when a
router does not know how to forward the datagram or when one fragment of
a datagram fails to arrive at the destination—it does not necessarily
fail silently. IP is always configured with a companion protocol, known
as the *Internet Control Message Protocol* (ICMP), that defines a
collection of error messages that are sent back to the source host
whenever a router or host is unable to process an IP datagram
successfully. For example, ICMP defines error messages indicating that
the destination host is unreachable (perhaps due to a link failure),
that the reassembly process failed, that the TTL had reached 0, that the
IP header checksum failed, and so on.

ICMP also defines a handful of control messages that a router can send
back to a source host. One of the most useful control messages, called
an *ICMP-Redirect*, tells the source host that there is a better route
to the destination. ICMP-Redirects are used in the following situation.
Suppose a host is connected to a network that has two routers attached
to it, called *R1* and *R2*, where the host uses R1 as its default
router. Should R1 ever receive a datagram from the host, where based on
its forwarding table it knows that R2 would have been a better choice
for a particular destination address, it sends an ICMP-Redirect back to
the host, instructing it to use R2 for all future datagrams addressed to
that destination. The host then adds this new route to its forwarding
table.

ICMP also provides the basis for two widely used debugging tools,
``ping`` and ``traceroute``. ``ping`` uses ICMP echo messages to
determine if a node is reachable and alive. ``traceroute`` uses a
slightly non-intuitive technique to determine the set of routers along
the path to a destination, which is the topic for one of the exercises
at the end of this chapter.

Virtual Networks and Tunnels
----------------------------

We conclude our introduction to IP by considering an issue you might
not have anticipated, but one that is increasingly important. Our
discussion up to this point has focused on making it possible for
nodes on different networks to communicate with each other in an
unrestricted way. This is usually the goal in the Internet—everybody
wants to be able to send email to everybody, and the creator of a new
website wants to reach the widest possible audience. However, there are
many situations where more controlled connectivity is required. An
important example of such a situation is the *virtual private network*
(VPN).

The term *VPN* is heavily overused and definitions vary, but intuitively
we can define a VPN by considering first the idea of a private network.
Corporations with many sites often build private networks by leasing
circuits from the phone companies and using those lines to
interconnect sites. In such a network, communication is restricted to
take place only among the sites of that corporation, which is often
desirable for security reasons. To make a private network *virtual*, the
leased transmission lines—which are not shared with any other
corporations—would be replaced by some sort of shared network. A virtual
circuit (VC) is a very reasonable replacement for a leased line because
it still provides a logical point-to-point connection between the
corporation’s sites. For example, if corporation X has a VC from site A
to site B, then clearly it can send packets between sites A and B. But
there is no way that corporation Y can get its packets delivered to
site B without first establishing its own virtual circuit to site B, and
the establishment of such a VC can be administratively prevented, thus
preventing unwanted connectivity between corporation X and
corporation Y.

:numref:`Figure %s(a) <fig-vpn>` shows two private networks for two
separate corporations. In :numref:`Figure %s(b) <fig-vpn>` they are
both migrated to a virtual circuit network. The limited connectivity
of a real private network is maintained, but since the private
networks now share the same transmission facilities and switches we
say that two virtual private networks have been created.

.. _fig-vpn:
.. figure:: figures/f03-26-9780123850591.png
   :width: 500px
   :align: center

   An example of virtual private networks: (a) two
   separate private networks; (b) two virtual private networks
   sharing common switches.

In :numref:`Figure %s <fig-vpn>`, a virtual circuit network (using ATM, for
example) is used to provide the controlled connectivity among sites. It
is also possible to provide a similar function using an IP network to
provide the connectivity. However, we cannot just connect the various
corporations’ sites to a single internetwork because that would provide
connectivity between corporation X and corporation Y, which we wish to
avoid. To solve this problem, we need to introduce a new concept, the
*IP tunnel*.

We can think of an IP tunnel as a virtual point-to-point link between a
pair of nodes that are actually separated by an arbitrary number of
networks. The virtual link is created within the router at the entrance
to the tunnel by providing it with the IP address of the router at the
far end of the tunnel. Whenever the router at the entrance of the tunnel
wants to send a packet over this virtual link, it encapsulates the
packet inside an IP datagram. The destination address in the IP header
is the address of the router at the far end of the tunnel, while the
source address is that of the encapsulating router.

.. _fig-tunnel:
.. figure:: figures/f03-27-9780123850591.png
   :width: 600px
   :align: center

   A tunnel through an internetwork. 18.5.0.1 is the
   address of R2 that can be reached from R1 across the
   internetwork.

In the forwarding table of the router at the entrance to the tunnel,
this virtual link looks much like a normal link. Consider, for
example, the network in :numref:`Figure %s <fig-tunnel>`. A tunnel has
been configured from R1 to R2 and assigned a virtual interface number
of 0. The forwarding table in R1 might therefore look like
:numref:`Table %s <tab-tunneltab>`.

.. _tab-tunneltab:
.. table:: Forwarding Table for Router R1.
   :align: center
   :widths: auto

   +------------+---------------------+
   | NetworkNum | NextHop             |
   +============+=====================+
   | 1          | Interface 0         |
   +------------+---------------------+
   | 2          | Virtual interface 0 |
   +------------+---------------------+
   | Default    | Interface 1         |
   +------------+---------------------+

R1 has two physical interfaces. Interface 0 connects to network 1;
interface 1 connects to a large internetwork and is thus the default for
all traffic that does not match something more specific in the
forwarding table. In addition, R1 has a virtual interface, which is the
interface to the tunnel. Suppose R1 receives a packet from network 1
that contains an address in network 2. The forwarding table says this
packet should be sent out virtual interface 0. In order to send a packet
out this interface, the router takes the packet, adds an IP header
addressed to R2, and then proceeds to forward the packet as if it had
just been received. R2’s address is 18.5.0.1; since the network number
of this address is 18, not 1 or 2, a packet destined for R2 will be
forwarded out the default interface into the internetwork.

Once the packet leaves R1, it looks to the rest of the world like a
normal IP packet destined to R2, and it is forwarded accordingly. All
the routers in the internetwork forward it using normal means, until
it arrives at R2. When R2 receives the packet, it finds that it
carries its own address, so it removes the IP header and looks at the
payload of the packet. What it finds is an inner IP packet whose
destination address is in network 2. R2 now processes this packet like
any other IP packet it receives. Since R2 is directly connected to
network 2, it forwards the packet on to that network. :numref:`Figure
%s <fig-tunnel>` shows the change in encapsulation of the packet as it
moves across the network.

While R2 is acting as the endpoint of the tunnel, there is nothing to
prevent it from performing the normal functions of a router. For
example, it might receive some packets that are not tunneled, but that
are addressed to networks that it knows how to reach, and it would
forward them in the normal way.

You might wonder why anyone would want to go to all the trouble of
creating a tunnel and changing the encapsulation of a packet as it goes
across an internetwork. One reason is security. Supplemented with
encryption, a tunnel can become a very private sort of link across a
public network. Another reason may be that R1 and R2 have some
capabilities that are not widely available in the intervening networks,
such as multicast routing. By connecting these routers with a tunnel, we
can build a virtual network in which all the routers with this
capability appear to be directly connected. A third reason to build
tunnels is to carry packets from protocols other than IP across an IP
network. As long as the routers at either end of the tunnel know how to
handle these other protocols, the IP tunnel looks to them like a
point-to-point link over which they can send non-IP packets. Tunnels
also provide a mechanism by which we can force a packet to be delivered
to a particular place even if its original header—the one that gets
encapsulated inside the tunnel header—might suggest that it should go
somewhere else. Thus, we see that tunneling is a powerful and quite
general technique for building virtual links across internetworks. So
general, in fact, that the technique recurses, with the most common use
case being to tunnel IP over IP.

Tunneling does have its downsides. One is that it increases the length
of packets; this might represent a significant waste of bandwidth for
short packets. Longer packets might be subject to fragmentation, which
has its own set of drawbacks. There may also be performance implications
for the routers at either end of the tunnel, since they need to do more
work than normal forwarding as they add and remove the tunnel header.
Finally, there is a management cost for the administrative entity that
is responsible for setting up the tunnels and making sure they are
correctly handled by the routing protocols.
