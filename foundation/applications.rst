1.1 Applications
================

Most people know the Internet through its applications: the World Wide
Web, email, social media, streaming music or movies, videoconferencing,
instant messaging, file-sharing, to name just a few examples. That is to
say, we interact with the Internet as *users* of the network. Internet
users represent the largest class of people who interact with the
Internet in some way, but there are several other important
constituencies.

There is the group of people who *create* the applications—a group that
has greatly expanded in recent years as powerful programming platforms
and new devices such as smartphones have created new opportunities to
develop applications quickly and to bring them to a large market.

Then there are those who *operate* or *manage* networks—mostly a
behind-the-scenes job, but a critical one and often a very complex one.
With the prevalence of home networks, more and more people are also
becoming, if only in a small way, network operators.

Finally, there are those who *design* and *build* the devices and
protocols that collectively make up the Internet. That final
constituency is the traditional target of networking textbooks such as
this one and will continue to be our main focus. However, throughout
this book we will also consider the perspectives of application
developers and network operators.

Considering these perspectives will enable us to better understand the
diverse requirements that a network must meet. Application developers
will also be able to make applications that work better if they
understand how the underlying technology works and interacts with the
applications. So, before we start figuring out how to build a network,
let’s look more closely at the types of applications that today’s
networks support.

Classes of Applications
-----------------------

The World Wide Web is the Internet application that catapulted the
Internet from a somewhat obscure tool used mostly by scientists and
engineers to the mainstream phenomenon that it is today. The Web itself
has become such a powerful platform that many people confuse it with the
Internet, and it’s a bit of a stretch to say that the Web is a single
application.

In its basic form, the Web presents an intuitively simple interface.
Users view pages full of textual and graphical objects and click on
objects that they want to learn more about, and a corresponding new page
appears. Most people are also aware that just under the covers each
selectable object on a page is bound to an identifier for the next page
or object to be viewed. This identifier, called a Uniform Resource
Locator (URL), provides a way of identifying all the possible objects
that can be viewed from your web browser. For example,

.. code-block:: html

   http://www.cs.princeton.edu/llp/index.html

is the URL for a page providing information about one of this book’s
authors: the string ``http`` indicates that the Hypertext Transfer
Protocol (HTTP) should be used to download the page,
``www.cs.princeton.edu`` is the name of the machine that serves the
page, and ``/llp/index.html`` uniquely identifies Larry’s home page at
this site.

What most web users are not aware of, however, is that by clicking on
just one such URL over a dozen messages may be exchanged over the
Internet, and many more than that if the web page is complicated with
lots of embedded objects. This message exchange includes up to six
messages to translate the server name (``www.cs.princeton.edu``) into
its Internet Protocol (IP) address (``128.112.136.35``), three messages
to set up a Transmission Control Protocol (TCP) connection between your
browser and this server, four messages for your browser to send the HTTP
“GET” request and the server to respond with the requested page (and for
each side to acknowledge receipt of that message), and four messages to
tear down the TCP connection. Of course, this does not include the
millions of messages exchanged by Internet nodes throughout the day,
just to let each other know that they exist and are ready to serve web
pages, translate names to addresses, and forward messages toward their
ultimate destination.

Another widespread application class of the Internet is the delivery of
“streaming” audio and video. Services such as video on demand and
Internet radio use this technology. While we frequently start at a
website to initiate a streaming session, the delivery of audio and video
has some important differences from fetching a simple web page of text
and images. For example, you often don’t want to download an entire
video file—a process that might take a few minutes—before watching the
first scene. Streaming audio and video implies a more timely transfer of
messages from sender to receiver, and the receiver displays the video or
plays the audio pretty much as it arrives.

Note that the difference between streaming applications and the more
traditional delivery of text, graphics, and images is that humans
consume audio and video streams in a continuous manner, and
discontinuity—in the form of skipped sounds or stalled video—is not
acceptable. By contrast, a regular (non-streaming) page can be
delivered and read in bits and pieces. This difference affects how the
network supports these different classes of applications.

A subtly different application class is *real-time* audio and video.
These applications have considerably tighter timing constraints than
streaming applications. When using a voice-over-IP application such as
Skype or a videoconferencing application, the interactions among the
participants must be timely. When a person at one end gestures, then
that action must be displayed at the other end as quickly as possible.\ [#]_

.. [#] Not quite “as soon as possible”… Human factors research
       indicates 300 ms is a reasonable upper bound for how much
       round-trip delay can be tolerated in a telephone call before
       humans complain, and a 100-ms delay sounds very good.

When one person tries to interrupt another, the interrupted person needs
to hear that as soon as possible and decide whether to allow the
interruption or to keep talking over the interrupter. Too much delay in
this sort of environment makes the system unusable. Contrast this with
video on demand where, if it takes several seconds from the time the
user starts the video until the first image is displayed, the service is
still deemed satisfactory. Also, interactive applications usually entail
audio and/or video flows in both directions, while a streaming
application is most likely sending video or audio in only one direction.

.. _fig-vic:
.. figure:: figures/f01-01-9780123850591.png
   :width: 600px
   :align: center

   A multimedia application including videoconferencing.

Videoconferencing tools that run over the Internet have been around now
since the early 1990s but have achieved widespread use in the last few
years, with several commercial products on the market. An example of one
such system is shown in :numref:`Figure %s <fig-vic>`.  Just as
downloading a web page involves a bit more than meets the eye, so too
with video applications. Fitting the video content into a relatively
low bandwidth network, for example, or making sure that the video and
audio remain in sync and arrive in time for a good user experience are
all problems that network and protocol designers have to worry
about. We’ll look at these and many other issues related to multimedia
applications later in the book.

Although they are just two examples, downloading pages from the web and
participating in a videoconference demonstrate the diversity of
applications that can be built on top of the Internet and hint at the
complexity of the Internet’s design. Later in the book we will develop a
more complete taxonomy of application types to help guide our discussion
of key design decisions as we seek to build, operate, and use networks
that such a wide range of applications. The book concludes by revisiting
these two specific applications, as well as several others that
illustrate the breadth of what is possible on today’s Internet.

For now, this quick look at a few typical applications will suffice to
enable us to start looking at the problems that must be addressed if we
are to build a network that supports such application diversity.
