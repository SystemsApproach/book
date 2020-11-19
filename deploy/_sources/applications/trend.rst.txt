Perspective: The Cloud is the New Internet
==========================================

As we saw at the end of :ref:`Section 9.1 <9.1 Traditional
Applications>`, there has been a migration of traditional Internet
applications like email and web servers from machines running
on-premises to VMs running in commodity clouds. This corresponds to a
shift in terminology (from “Web Services” to “Cloud Services”) and in
many of the underlying technologies being used (from Virtual Machines
to Cloud Native micro-services). But the Cloud’s impact on how network
applications are implemented today is even bigger than this migration
suggests. It is the combination of commodity clouds and overlay
networks (similar to those described in :ref:`Section 9.4 <9.4 Overlay
Networks>`) that may eventually have the most impact.

The biggest thing an overlay-based application needs to be effective is
a wide footprint, that is, many points-of-presence around the world. IP
routers are widely deployed, so if you have permission to use a set of
them as the underlying nodes in your overlay network, then you’re
good-to-go. But that’s not going to happen, as there are exactly zero
network operators or enterprise administrators that are willing to let
random people load overlay software onto their routers.

Your next choice might be to crowdsource hosting sites for your overlay
software. Depending on the kindness of strangers works if you all share
a common goal, like downloading free music, but it’s difficult for a new
overlay application to go viral, and even if it does, making sure there
is sufficient capacity at any given time to carry all the traffic your
application generates is often problematic. It sometimes works for free
services, but not any application you might hope to monetize.

If only there were a way to pay someone for the right to load and run
your software on servers spread all over the world. Of course, that’s
exactly what commodity clouds like Amazon AWS, Microsoft Azure, and
the Google Cloud Platform provide. To many, the cloud offers a
seemingly unlimited number of servers, but it’s actually just as
important—if not more important—where these servers are located. As we
discussed at the end of :ref:`Chapter 4 <Perspective: The Cloud is
Eating the Internet>`, they are widely distributed across 150+
well-connected sites.

Suppose, for example, that you want to stream a collection of live video
or audio channels to millions of users, or you want to support thousands
of video conferencing sessions, each of which connects a dozen widely
distributed participants. In both cases, you construct an overlay
multicast tree (one per video channel in the first example, and one per
conference session in the second example), with the overlay nodes in the
tree located at some combination of those 150 cloud sites. Then you
allow the end-users, from their general-purpose web browsers or
purpose-built smartphone apps, connect to the multicast tree(s) of their
choice. If you need to store some of the video/audio content to play at
a later time (e.g., to support time shifting) then you might also buy
some storage capacity at some or all of those cloud sites, effectively
building your own Content Distribution Network.

Taking the long view, while the Internet was originally conceived as a
pure communication service, with arbitrary compute-and-storage
applications allowed to flourish around the edges, today application
software is for all practical purposes embedded within (distributed
across) the network, and it is increasingly difficult to tell where
the Internet stops and the Cloud starts. This blending will only
continue to deepen as the cloud moves closer and closer to the edge
(e.g., to thousands of sites where access networks are anchored) and
the economies-of-scale drive the hardware devices used to build
Internet/Cloud sites increasingly towards commonality.

.. admonition:: Broader Perspective

   To remind yourself of why the cloudification of the Internet is
   important, see :ref:`Perspective: Feature Velocity`.
