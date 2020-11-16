8.1 Trust and Threats
=====================

Before we address the how’s and why’s of building secure networks, it is
important to establish one simple truth: We will inevitably fail. This
is because security is ultimately an exercise in making assumptions
about trust, evaluating threats, and mitigating risk. There is no such
thing as perfect security.

Trust and threats are two sides of the same coin. A threat is a
potential failure scenario that you design your system to avoid, and
trust is an assumption you make about how external actors and internal
components you build upon will behave. For example, if you are
transmitting a message over WiFi on an open campus, you would likely
identify an eavesdropper that can intercept the message as a threat (and
adopt some of the methods discussed in this chapter as a
countermeasure), but if you are transmitting a message over a fiber link
between two machines in a locked datacenter, you might trust that
channel is secure, and so take no additional steps.

You could argue that since you already have a way to protect
WiFi-based communication you just as well use it to protect the
fiber-based channel, but that presumes the outcome of a cost/benefit
analysis.  Suppose protecting any message, whether sent over WiFi or
fiber, slows the communication down by 10% due to the overhead of
encryption. If you need to squeeze every last ounce of performance out
of a scientific computation (e.g., you are trying to model a
hurricane) and the odds of someone breaking into the datacenter are
one in a million (and even if they did, the data being transmitted has
little value), then you would be well-justified in not securing the
fiber communication channel.

These sorts of calculations happen all the time, although they are often
implicit and unstated. For example, you may run the world’s most secure
encryption algorithm on a message before transmitting it, but you’ve
implicitly trusted that the server you’re running on is both faithfully
executing that algorithm and not leaking a copy of your unencrypted
message to an adversary. Do you treat this as a threat or do you trust
that the server does not misbehave? At the end of the day, the best you
can do is mitigate risk: identify those threats that you can eliminate
in a cost effective way, and be explicit about what trust assumptions
you are making so you aren’t caught off-guard by changing circumstances,
such as an ever more determined or sophisticated adversary.

In this particular example, the threat of an adversary compromising a
server has become quite real as more of our computations move from local
servers into the cloud, and so research is now going into building a
*Trusted Computing Base* (TCB), an interesting topic, but one that is in
the realm of computer architecture rather than computer networks. For
the purpose of this chapter, our recommendation is to pay attention to
the words *trust* and *threat* (or adversary), as they are key to
understanding the context in which security claims are made.

There is one final historical note that helps set the table for this
chapter. The Internet (and the ARPANET before it) where funded by the
U.S. Department of Defense, an organization that certainly understands
threat analysis. The original assessment was dominated by concerns about
the network surviving in the face of routers and networks failing (or
being destroyed), which explains why the routing algorithms are
decentralized, with no central point of failure. On the other hand, the
original design assumed all actors *inside* the network were trusted,
and so little or no attention was paid what today we would call
cybersecurity (attacks from bad actors that are able to connect to the
network). What this means is that many of the tools described in this
chapter could be considered patches. They are strongly-grounded in
cryptography, but “add-ons” nonetheless. If a comprehensive redesign of
the Internet were to take place, integrating security would likely be
the foremost driving factor.
