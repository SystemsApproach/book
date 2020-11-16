Problem: Applications Need Their Own Protocols
----------------------------------------------

We started this book by talking about application programs—everything
from web browsers to videoconferencing tools—that people want to run
over computer networks. In the intervening chapters, we have developed,
one building block at a time, the networking infrastructure needed to
make such applications possible. We have now come full circle, back to
network applications. These applications are part network protocol (in
the sense that they exchange messages with their peers on other
machines) and part traditional application program (in the sense that
they interact with the windowing system, the file system, and ultimately
the user). This chapter explores some popular network applications
available today.

Looking at applications drives home the *systems approach* that we have
emphasized throughout this book. That is, the best way to build
effective networked applications is to understand the building blocks
that a network can provide and how those blocks can interact with each
other. Thus, for example, a particular networked application might need
to make use of a reliable transport protocol, authentication and privacy
mechanisms, and resource allocation capabilities of the underlying
network. Applications often work best when the application developer
knows how to make the best use of these facilities (and there are also
plenty of counter-examples of applications making poor use of available
networking capabilities). Applications typically need their own
protocols, too, in many cases using the same principles that we have
seen in our prior examination of lower layer protocols. Thus, our focus
in this chapter is on how to put together the ideas and techniques
already described to build effective networked applications. Said
another way, if you ever imagine yourself writing a network application,
then you will by definition also become a protocol designer (and
implementer).

We proceed by examining a variety of familiar, and not so familiar,
network applications. These range from exchanging email and surfing the
Web, to integrating applications across businesses, to multimedia
applications like videoconferencing, to managing a set of network
elements, to emerging peer-to-peer and content distribution networks.
This list is by no means exhaustive, but it does serve to illustrate
many of the key principles of designing and building applications.
Applications need to pick and choose the appropriate building blocks
that are available at other layers either inside the network or in the
host protocol stacks and then augment those underlying services to
provide the precise communication service required by the application.
