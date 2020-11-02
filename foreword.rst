Foreword
========

Readers: before you start the book, first take a moment and set your
time machine to 1996. That is when the first edition of this book was
published. Do you remember 1996? Were you alive then?  People forget
how long ago the foundations of the Internet were laid.

In 1996, the NSFNET had just been decommissioned, and the commercial
phase of the Internet was just beginning. The first search engine
(Alta Vista—do you remember?) had just been demonstrated. Content
delivery networks did not exist—Akamai was founded two years later
in 1998, the same year Google was officially born. Cloud was only a
distant haze on the horizon. And there was no such thing as
residential broadband or consumer wireless.  We used dialup modems—the
56K modem had just been invented. There were packet radios before
then, but they were slower than dialup and the size of a beer
fridge. You needed a truck or at least a Jeep to be mobile.

And in 1995 or so, Larry and Bruce decided to write this book. It may
be hard, from today’s perspective, to remember how important a book
like this was in 1996. It captured a lot of tacit knowledge and made
it available to anyone who would read. And rather than just reciting a
series of protocol descriptions, it taught how the parts fit
together. It taught how the Internet worked, not just what the parts
were.

One way to think about how the Internet has evolved is through the
lens of the application designer. After all, the purpose of the
Internet as a packet transport system is to support apps. Only geeks
and performance freaks send packets for the fun of it.  In 1996, if
you wanted to build an application, the ecosystem included the IP
packet transport service, TCP to smooth out the losses at the Internet
layer, the DNS, and that was about it. Anything else the application
designer needed had to be built from scratch.

Now an application designer has lots of resources to build on: cloud
and cloud networks, other global networks that can hook services
together, CDNs, app development environments and so on. Some of these
may seem quite different from what we had in 1996 and in detail they
are. Consider cloud. (I hate the choice of the term—to me “cloud”
suggests something soft and fluffy, but if you have ever seen a data
center the size of a football field that sucks megawatts, you would
not think soft and fluffy. But never mind…) Data centers have become
very sophisticated about cost, energy efficiency, performance and
resilience. There is a lot to learn about how to build a modern data
center. But the fundamentals are the same: packet forwarding,
statistical capacity sharing, transport protocols, routing protocols,
the pursuit of generality and broad utility, and the like.

Looking forward, technologies such as cloud are clearly central and
this edition devotes considerable attention to cloud. Requirements
such as improving security are critical, and the book discusses
additional issues related to security: trust, identity, and the latest
hot topic—blockchain.  However, if you were to look at the first
edition, many of the foundational concepts are the same. But this
edition is the modern version of the story, with up to date examples
and modern technology. Enjoy.


| David Clark
| MIT
| October 2020
