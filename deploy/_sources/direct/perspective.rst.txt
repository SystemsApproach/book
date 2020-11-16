2.1 Technology Landscape
========================

Before diving into the challenges outlined in the problem statement at
the beginning of this chapter, it is helpful to first get a lay of the
land, which includes a wide array of link technologies. This is due, in
part, to the diverse circumstances under which users are trying to
connect their devices.

At one end of the spectrum, network operators that build global networks
must deal with links that span hundreds or thousands of kilometers
connecting refrigerator-sized routers. At the other end of the spectrum,
a typical user encounters links mostly as a way to connect a computer to
the existing Internet. Sometimes this link will be a wireless (Wi-Fi)
link in a coffee shop; sometimes it’s an Ethernet link in an office
building or university; sometimes it is a smartphone connected to a
cellular network; for an increasingly large slice of the population it
is a fiber optic link provided by an ISP; and many others use some sort
of copper wire or cable to connect. Fortunately, there are many common
strategies used on these seemingly disparate types of links so that they
can all be made reliable and useful to higher layers in the protocol
stack. This chapter examines those strategies.

.. _fig-isp-access:
.. figure:: figures/f02-01-9780123850591.png
   :width: 650px
   :align: center
   
   An end-user's view of the Internet.

:numref:`Figure %s <fig-isp-access>` illustrates various types of
links that might be found in today’s Internet. On the left, we see a
variety of end-user devices ranging from smartphones to tablets to
full-fledged computers connected by various means to an ISP. While
those links might use different technologies, they all look the same
in this picture—a straight line connecting a device to a router. There
are links that connect routers together inside the ISP, as well as
links that connect the ISP to the “rest of the Internet,” which
consists of lots of other ISPs and the hosts to which they connect.

These links all look alike not just because we’re not very good artists
but because part of the role of a network architecture is to provide a
common abstraction of something as complex and diverse as a link. The
idea is that your laptop or smartphone doesn’t have to care what sort of
link it is connected to—the only thing that matters is that it has a
link to the Internet. Similarly, a router doesn’t have to care what sort
of link connects it to other routers—it can send a packet on the link
with a pretty good expectation that the packet will reach the other end
of the link.

How do we make all these different types of links look sufficiently
alike to end users and routers? Essentially, we have to deal with all
the physical limitations and shortcomings of links that exist in the
real world. We sketched out some of these issues in the opening problem
statement for this chapter, but before we can discuss these, we need to
first introduce some simple physics. All of these links are made of some
physical material that can propagate signals, such as radio waves or
other sorts of electromagnetic radiation, but what we really want to do
is send *bits*. In the later sections of this chapter, we’ll look at how
to encode bits for transmission on a physical medium, followed by the
other issues mentioned above. By the end of this chapter, we’ll
understand how to send complete packets over just about any sort of
link, no matter what physical medium is involved.

One way to characterize links, then, is by the medium they
use—typically, copper wire in some form, such as twisted pair (some
Ethernets and landline phones) and coaxial (cable); optical fiber,
which is used for both fiber-to-the-home and many long-distance links
in the Internet’s backbone; or air/free space for wireless links.

Another important link characteristic is the *frequency*, measured in
hertz, with which the electromagnetic waves oscillate. The distance
between a pair of adjacent maxima or minima of a wave, typically
measured in meters, is called the wave’s *wavelength*. Since all
electromagnetic waves travel at the speed of light (which in turn
depends on the medium), that speed divided by the wave’s frequency is
equal to its wavelength. We have already seen the example of a
voice-grade telephone line, which carries continuous electromagnetic
signals ranging between 300 Hz and 3300 Hz; a 300-Hz wave traveling
through copper would have a wavelength of

.. centered:: SpeedOfLightInCopper / Frequency

.. centered:: = 2/3 × 3 × 10\ :sup:`8` / 300
   
.. centered:: = 667 × 10\ :sup:`3` *meters*

Generally, electromagnetic waves span a much wider range of
frequencies, ranging from radio waves, to infrared light, to visible
light, to x-rays and gamma rays. :numref:`Figure %s <fig-spectrum>`
depicts the electromagnetic spectrum and shows which media are
commonly used to carry which frequency bands.
 
.. _fig-spectrum:
.. figure:: figures/f02-02-9780123850591.png
   :width: 600px
   :align: center
   
   Electromagnetic spectrum.

What :numref:`Figure %s <fig-spectrum>` doesn't show is where the
cellular network fits in. This is a bit complicated because the
specific frequency bands that are licensed for cellular networks vary
around the world, and even further complicated by the fact that
network operators often simultaneously support both old/legacy
technologies and new/next-generation technologies, each of which
occupies a different frequency band. The high-level summary is that
traditional cellular technologies range from 700-MHz to 2400-MHz, with
new mid-spectrum allocations now happening at 6-GHz, and
millimeter-wave (mmWave) allocations opening above 24-GHz. This mmWave
band is likely to become an important part of the 5G mobile network.

So far we understand a link to be a physical medium carrying signals in
the form of electromagnetic waves. Such links provide the foundation for
transmitting all sorts of information, including the kind of data we are
interested in transmitting—binary data (1s and 0s). We say that the
binary data is *encoded* in the signal. The problem of encoding binary
data onto electromagnetic signals is a complex topic. To help make the
topic more manageable, we can think of it as being divided into two
layers. The lower layer is concerned with *modulation*—varying the
frequency, amplitude, or phase of the signal to effect the transmission
of information. A simple example of modulation is to vary the power
(amplitude) of a single wavelength. Intuitively, this is equivalent to
turning a light on and off. Because the issue of modulation is secondary
to our discussion of links as a building block for computer networks, we
simply assume that it is possible to transmit a pair of distinguishable
signals—think of them as a “high” signal and a “low” signal—and we
consider only the upper layer, which is concerned with the much simpler
problem of encoding binary data onto these two signals. The next section
discusses such encodings.

Another way to classify links is in terms of how they are
used. Various economic and deployment issues tend to influence where
different link types are found. Most consumers interact with the
Internet either through wireless networks (which they encounter in
coffee shops, airports, universities, etc.) or through so-called
*last-mile* links (or alternatively, *access networks*) provided by an
ISP, as illustrated in :numref:`Figure %s <fig-isp-access>`. These
link types are summarized in :numref:`Table %s <tab-home>`. They
typically are chosen because they are cost-effective ways of reaching
millions of consumers. DSL (Digital Subscriber Line), for example, is
an older technology that was deployed over the existing twisted pair
copper wires that already existed for plain old telephone services;
G.Fast is a copper-based technology typically used within
multi-dwelling apartment buildings, and PON (Passive Optical Network)
is a newer technology that is commonly used to connect homes and
businesses over recently deployed fiber.

.. _tab-home:
.. table::  Common services available for the last-mile connection to your home. 
   :widths: auto
   :align: center
	   
   +-----------------+----------------+
   | Service         | Bandwidth      |
   +=================+================+
   | DSL (copper)    | up to 100 Mbps |
   +-----------------+----------------+
   | G.Fast (copper) | up to 1 Gbps   |
   +-----------------+----------------+
   | PON (optical)   | up to 10 Gbps  |
   +-----------------+----------------+

And of course there is also the *mobile* or *cellular* network (also
referred to as 4G, but which is rapidly evolving into 5G) that connects
our mobile devices to the Internet. This technology can also serve as
the sole Internet connection into our homes or offices, but comes with
the added benefit of allowing us to maintain Internet connectivity while
moving from place to place.

These example technologies are common options for the last-mile
connection to your home or business, but they are not sufficient for
building a complete network from scratch. To do that, you’ll also need
some long-distance *backbone* links to interconnect cities. Modern
backbone links are almost exclusively fiber today, and they typically
use a technology called SONET (Synchronous Optical Network), which was
originally developed to meet the demanding management requirements of
telephone carriers.

Finally, in addition to last-mile, backbone, and mobile links, there are
the links that you find inside a building or a campus—generally referred
to as *local area networks* (LANs). Ethernet, and its wireless cousin
Wi-Fi, are the dominant technologies in this space.

This survey of link types is by no means exhaustive, but it should have
given you a taste of the diversity of link types that exist and some of
the reasons for that diversity. In the coming sections, we will see how
networking protocols can take advantage of that diversity and present a
consistent view of the network to higher layers in spite of all the
low-level complexity and economic factors.
