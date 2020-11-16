Problem: Getting Processes to Communicate
-----------------------------------------

Many technologies can be used to connect together a collection of
computers, ranging from simple Ethernets and wireless networks to
global-scale internetworks. Once interconnected, the next problem is to
turn this host-to-host packet delivery service into a process-to-process
communication channel. This is the role played by the *transport* level
of the network architecture, which, because it supports communication
between application programs running in end nodes, is sometimes called
the *end-to-end* protocol.

Two forces shape the end-to-end protocol. From above, the
application-level processes that use its services have certain
requirements. The following list itemizes some of the common properties
that a transport protocol can be expected to provide:

-  Guarantees message delivery

-  Delivers messages in the same order they are sent

-  Delivers at most one copy of each message

-  Supports arbitrarily large messages

-  Supports synchronization between the sender and the receiver

-  Allows the receiver to apply flow control to the sender

-  Supports multiple application processes on each host

Note that this list does not include all the functionality that
application processes might want from the network. For example, it does
not include security features like authentication or encryption, which
are typically provided by protocols that sit above the transport level.
(We discuss security-related topics in a later chapter.)

From below, the underlying network upon which the transport protocol
operates has certain limitations in the level of service it can provide.
Some of the more typical limitations of the network are that it may

-  Drop messages

-  Reorder messages

-  Deliver duplicate copies of a given message

-  Limit messages to some finite size

-  Deliver messages after an arbitrarily long delay

Such a network is said to provide a *best-effort* level of service, as
exemplified by the Internet.

The challenge, therefore, is to develop algorithms that turn the
less-than-perfect properties of the underlying network into the high
level of service required by application programs. Different transport
protocols employ different combinations of these algorithms. This
chapter looks at these algorithms in the context of four representative
services—a simple asynchronous demultiplexing service, a reliable
byte-stream service, a request/reply service, and a service for
real-time applications.

In the case of the demultiplexing and byte-stream services, we use the
Internet’s User Datagram Protocol (UDP) and Transmission Control
Protocol (TCP), respectively, to illustrate how these services are
provided in practice. In the case of a request/reply service, we discuss
the role it plays in a Remote Procedure Call (RPC) service and what
features that entails. The Internet does not have a single RPC protocol,
so we cap this discussion off with a description of three widely used
RPC protocols: SunRPC, DCE-RPC, and gRPC.

Finally, real-time applications make particular demands on the transport
protocol, such as the need to carry timing information that allows audio
or video samples to be played back at the appropriate point in time. We
look at the requirements placed by applications on such a protocol and
the most widely used example, the Real-Time Transport Protocol (RTP).
