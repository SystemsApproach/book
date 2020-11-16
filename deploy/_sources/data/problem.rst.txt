Problem: What Do We Do with the Data?
-------------------------------------

From the network’s perspective, application programs send messages to
each other. Each of these messages is just an uninterpreted string of
bytes. From the application’s perspective, however, these messages
contain various kinds of *data*\ —arrays of integers, video frames, lines
of text, digital images, and so on. In other words, these bytes have
meaning. We now consider the problem of how best to encode the different
kinds of data that application programs want to exchange into byte
strings. In many respects, this is similar to the problem of encoding
byte strings into electromagnetic signals that we saw in an earlier
chapter.

Thinking back to our discussion of encoding, there are essentially two
concerns. The first is that the receiver be able to extract the same
message from the signal as the transmitter sent; this is the framing
problem. The second is making the encoding as efficient as possible.
Both of these concerns are also present when encoding application data
into network messages.

In order for the receiver to extract the message sent by the
transmitter, the two sides need to agree to a message format, often
called the *presentation format*. If the sender wants to send the
receiver an array of integers, for example, then the two sides have to
agree what each integer looks like (how many bits long it is, what order
the bytes are arranged in, and whether the most significant bit comes
first or last, for example) and how many elements are in the array. The
first section describes various encodings of traditional computer data,
such as integers, floating-point numbers, character strings, arrays, and
structures. Well-established formats also exist for multimedia data:
Video, for example, is typically transmitted in one of the formats
created by the Moving Picture Experts Group (MPEG), and still images are
usually transmitted in Joint Photographic Experts Group (JPEG) format.
The particular issues that arise in the encoding of multimedia data are
discussed in the next section.

Multimedia data types require us to think about both presentation and
*compression*. The well-known formats for the transmission and storage
of audio and video deal with both these issues: making sure that what
was recorded, photographed, or heard at the sender can be interpreted
correctly by the receiver, and doing so in a way that does not overwhelm
the network with massive amounts of multimedia data.

Compression and, more generally, the efficiency of encoding have a rich
history, dating back to Shannon’s pioneering work on information theory
in the 1940s. In effect, there are two opposing forces at work here. In
one direction, you would like as much redundancy in the data as possible
so that the receiver is able to extract the right data even if errors
are introduced into the message. The error detection and correcting
codes we saw in an earlier chapter add redundant information to messages
for exactly this purpose. In the other direction, we would like to
remove as much redundancy from the data as possible so that we may
encode it in as few bits as possible. It turns out the multimedia data
offers a wealth of opportunities for compression because of the way our
senses and brains process visual and auditory signals. We don’t hear
high frequencies as well as lower ones, and we don’t notice fine detail
as much as the bigger picture in an image, especially if the image is
moving.

Compression is important to the designers of networks for many reasons,
not just because we rarely find ourselves with an abundance of bandwidth
everywhere in the network. For example, the way we design a compression
algorithm affects our sensitivity to lost or delayed data and thus may
influence the design of resource allocation mechanisms and end-to-end
protocols. Conversely, if the underlying network is unable to guarantee
a fixed amount of bandwidth for the duration of a videoconference, we
may choose to design compression algorithms that can adapt to changing
network conditions.

Finally, an important aspect of both presentation formatting and data
compression is that they require the sending and receiving hosts to
process every byte of data in the message. It is for this reason that
presentation formatting and compression are sometimes called *data
manipulation* functions. This is in contrast to most of the protocols we
have seen up to this point, which process a message without ever looking
at its contents. Because of this need to read, compute on, and write
every byte of data in a message, data manipulations affect end-to-end
throughput over the network. In some cases, these manipulations can be
the limiting factor.
