Problem: Connecting to a Network
--------------------------------

In Chapter 1 we saw that networks consist of links interconnecting
nodes. One of the fundamental problems we face is how to connect two
nodes together. We also introduced the “cloud” abstraction to represent
a network without revealing all of its internal complexities. So we also
need to address the similar problem of connecting a host to a cloud.
This, in effect, is the problem every Internet Service Provider (ISP)
faces when it wants to connect a new customer to its network.

Whether we want to construct a trivial two-node network with one link or
connect the one-billionth host to an existing network like the Internet,
we need to address a common set of issues. First, we need some physical
medium over which to make the connection. The medium may be a length of
wire, a piece of optical fiber, or some less tangible medium (such as
air) through which electromagnetic radiation (e.g., radio waves) can be
transmitted. It may cover a small area (e.g., an office building) or a
wide area (e.g., transcontinental).

Connecting two nodes with a suitable medium is only the first step,
however. Five additional problems must be addressed before the nodes can
successfully exchange packets, and once addressed, we will have provided
*Layer 2* (L2) connectivity (using terminology from the OSI
architecture).

The first is *encoding* bits onto the transmission medium so that they
can be understood by a receiving node. Second is the matter of
delineating the sequence of bits transmitted over the link into complete
messages that can be delivered to the end node. This is the *framing*
problem, and the messages delivered to the end hosts are often called
*frames* (or sometimes *packets*). Third, because frames are sometimes
corrupted during transmission, it is necessary to detect these errors
and take the appropriate action; this is the *error detection* problem.
The fourth issue is making a link appear reliable in spite of the fact
that it corrupts frames from time to time. Finally, in those cases where
the link is shared by multiple hosts—as is often the case with wireless
links, for example—it is necessary to mediate access to this link. This
is the *media access control* problem.

Although these five issues—encoding, framing, error detection, reliable
delivery, and access mediation—can be discussed in the abstract, they
are very real problems that are addressed in different ways by different
networking technologies. This chapter considers these issues in the
context of specific network technologies: point-to-point fiber links
(for which SONET is the prevalent example); Carrier Sense Multiple
Access (CSMA) networks (of which classical Ethernet and Wi-Fi are the
most famous examples); fiber-to-the home (for which PON is the
dominant standard); and mobile wireless (where 4G is rapidly morphing
into 5G).

The goal of this chapter is simultaneously to survey the available
link-level technology and to explore these five fundamental issues. We
will examine what it takes to make a wide variety of different physical
media and link technologies useful as building blocks for the
construction of robust, scalable networks.
