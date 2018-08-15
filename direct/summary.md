# {{ page.title }}

This chapter introduced the many and varied types of links that are used
to connect users to existing networks and to construct large networks
from scratch. While links vary enormously in their detailed
characteristics, there are many problems and techniques for solving them
that are We looked at the five key problems that must be solved so that
two or more nodes connected by some medium can exchange messages with
each other.

The first problem is to encode the bits that make up a binary message
into the signal at the source node and then to recover the bits from the
signal at the receiving node. This is the encoding problem, and it is
made challenging by the need to keep the sender's and receiver's clocks
synchronized. We discussed four different encoding techniques—NRZ,
NRZI, Manchester, and 4B/5B—which differ largely in how they encode
clock information along with the data being transmitted. One of the key
attributes of an encoding scheme is its efficiency, the ratio of signal
pulses to encoded bits.

Once it is possible to transmit bits between nodes, the next step is to
figure out how to package these bits into frames. This is the framing
problem, and it boils down to being able to recognize the beginning and
end of each frame. Again, we looked at several different techniques,
including byte-oriented protocols, bit-oriented protocols, and
clock-based protocols.

Assuming that each node is able to recognize the collection of bits that
make up a frame, the third problem is to determine if those bits are in
fact correct or if they have possibly been corrupted in transit. This is
the error detection problem, and we looked at three different
approaches: cyclic redundancy check, two-dimensional parity, and
checksums. Of these, the CRC approach gives the strongest guarantees and
is the most widely used at the link level.

Given that some frames will arrive at the destination node containing
errors and thus will have to be discarded, the next problem is how to
recover from such losses. The goal is to make the link appear reliable.
The general approach to this problem is called *ARQ* and involves using
a combination of acknowledgments and timeouts. We looked at three
specific ARQ algorithms: stop-and-wait, sliding window, and concurrent
channels. What makes these algorithms interesting is how effectively
they use the link, with the goal being to keep the pipe full.

The final problem is not relevant to point-to-point links, but it is the
central issue in multiple-access links: how to mediate access to a
shared link so that all nodes eventually have a chance to transmit their
data. In this case, we looked at a variety of media access
protocols—Ethernet and several wireless protocols—that have been put
to practical use in building local area networks. Media access in
wireless networks is made more complicated by the fact that some nodes
may be hidden from each other due to range limitations of radio
transmission. Most of the common wireless protocols today designate some
nodes as wired or base-station nodes, while the other mobile nodes
communicate with a base station. Wireless standards and technologies are
rapidly evolving, with mesh networks, in which all nodes communicate as
peers, now beginning to emerge.

## Further Reading

One of the most important contributions in computer networking over the
last 20 years is the original paper by Metcalf and Boggs (1976)
introducing the Ethernet. Many years later, Boggs, Mogul, and Kent
(1988) reported their practical experiences with Ethernet, debunking
many of the myths that had found their way into the literature over the
years. Both papers are must reading. The third paper laid much of the
groundwork for the development of wireless networks including 802.11.

- Metcalf, R., and D. Boggs. Ethernet: Distributed packet switching
    for local computer networks. *Communications of the ACM*
    19(7):395-403, July 1976.

- Boggs, D., J. Mogul, and C. Kent. Measured capacity of an Ethernet.
    *Proceedings of the SIGCOMM '88 Symposium*, pages 222-234,
    August 1988.

- Bharghavan, V., A. Demers, S. Shenker, and L. Zhang. MACAW: A media
    access protocol for wireless LANs. *Proceedings of the SIGCOMM '94
    Symposium*, pages 212-225, August 1994.
