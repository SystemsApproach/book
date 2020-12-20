Problem: Building a Network
---------------------------

Suppose you want to build a computer network, one that has the potential
to grow to global proportions and to support applications as diverse as
teleconferencing, video on demand, electronic commerce, distributed
computing, and digital libraries. What available technologies would
serve as the underlying building blocks, and what kind of software
architecture would you design to integrate these building blocks into an
effective communication service? Answering this question is the
overriding goal of this book—to describe the available building
materials and then to show how they can be used to construct a network
from the ground up.

Before we can understand how to design a computer network, we should
first agree on exactly what a computer network is. At one time, the term
*network* meant the set of serial lines used to attach dumb terminals to
mainframe computers. Other important networks include the voice
telephone network and the cable TV network used to disseminate video
signals. The main things these networks have in common are that they are
specialized to handle one particular kind of data (keystrokes, voice, or
video) and they typically connect to special-purpose devices (terminals,
hand receivers, and television sets).

What distinguishes a computer network from these other types of
networks? Probably the most important characteristic of a computer
network is its generality. Computer networks are built primarily from
general-purpose programmable hardware, and they are not optimized for a
particular application like making phone calls or delivering television
signals. Instead, they are able to carry many different types of data,
and they support a wide, and ever growing, range of applications.
Today’s computer networks have pretty much taken over the functions
previously performed by single-use networks. This chapter looks at some
typical applications of computer networks and discusses the requirements
that a network designer who wishes to support such applications must be
aware of.

Once we understand the requirements, how do we proceed? Fortunately, we
will not be building the first network. Others, most notably the
community of researchers responsible for the Internet, have gone before
us. We will use the wealth of experience generated from the Internet to
guide our design. This experience is embodied in a *network
architecture* that identifies the available hardware and software
components and shows how they can be arranged to form a complete network
system.

In addition to understanding how networks are built, it is increasingly
important to understand how they are operated or managed and how network
applications are developed. Almost all of us now have computer networks
in our homes, offices, and in some cases in our cars, so operating
networks is no longer a matter only for a few specialists. And with the
proliferation of smartphones, many more of this generation are
developing networked applications than in the past. So we need to
consider networks from these multiple perspectives: builders, operators,
application developers.

To start us on the road toward understanding how to build, operate, and
program a network, this chapter does four things. First, it explores the
requirements that different applications and different communities of
people place on the network. Second, it introduces the idea of a network
architecture, which lays the foundation for the rest of the book. Third,
it introduces some of the key elements in the implementation of computer
networks. Finally, it identifies the key metrics that are used to
evaluate the performance of computer networks.
