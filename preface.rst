Preface
=======

It has been nearly ten years since the fifth edition of *Computer
Networks: A Systems Approach* was published. Much has changed in that
time, most notably, the explosion of the cloud and smartphone apps onto
the scene. In many ways, this is reminiscent of the dramatic effect the
Web was having on the Internet when we published the first edition of the
book in 1996.

The sixth edition adapts to the times, but keeps the *Systems Approach*
as its North Star. In broad strokes, we update and improve this new
edition in four main ways:

-  We refresh the examples to reflect the current state of the world.
   This includes deleting anachronisms (e.g., dial-up modem), using
   popular applications (e.g., Netflix, Spotify) to motivate the
   problems being addressed, and updating the numbers to represent the
   state-of-the-art technology (e.g., 10-Gbps Ethernet).

-  We connect the dots between the original research that led to the
   development of technologies like multicast, real-time video
   streaming, and quality-of-service, and the now-familiar cloud
   applications like Zoom, Netflix, and Spotify. This is in
   keeping with our emphasis on the design process and not just the
   end result, which is especially important today since so much of
   the Internet’s functionality is primarily delivered by
   proprietary commercial services. 


- We place the Internet in the broader context of the Cloud, and just
  as importantly, in the context of the commercial forces that are
  shaping the Cloud. This has minimal impact on the technical details
  presented throughout the book, but it is discussed in a new
  *Perspective* section at the end of each chapter. We hope one
  side-effect of this discussion is to foster an appreciation for the
  Internet’s continuous evolution, and the opportunity for innovation
  this represents.
  
- We distill the important principles of network design in a series
  of *Key Takeaways* throughout the book. Each takeaway is a concise
  statement of either a general system design rule or a fundamental
  networking concept, drawing on the examples presented in the
  surrounding text. Pedagogically, these takeaways correspond to the
  high-level *learning objectives* for the book.

What is "A Systems Approach"?
------------------------------

The "Systems Approach" refers to the field of design and
implementation of computer systems. The term is used commonly by
computer science researchers and practitioners who study the issues
that arise when building complex computing systems such as operating
systems, networks, distributed applications, etc. The key to the
systems approach is a "big picture" view: you need to look at how the
components of a system interact with each other to achieve an overall
result, rather than simply optimizing each component. In the
networking context, that often means going beyond the traditional
layered view to see how an issue is best tackled in a way that might
touch several layers. A good example of this is congestion control,
which touches multiple layers and affects both end systems and network
devices. We treat congestion, a system-wide issue, in its own chapter rather than trying to
shoehorn it into the transport layer, for example. The Systems Approach has a strong focus on
real-world implementation, with the Internet being the obvious example
of a widely-deployed, complex networking system. 


New Material in the Sixth Edition
---------------------------------
  
More specifically, the sixth edition includes the following major changes:

-  New Perspective Section in Chapter 1 introduces the recurring
   *Cloudification* theme.
-  New Section 2.8 describes the *Access Network*, including Passive
   Optical Networks (PON) and 5G’s Radio Access Networks (RAN).
-  Refactored topics across Sections 3.1 (*Switching Basics*) and 3.2
   (*Switched Ethernet*), including expanded coverage of VLANs.
-  Section 3.5 updated to include descriptions of *Bare-Metal Switches*
   and *Software-Defined Networks* (SDN).
-  New Perspective Section in Chapter 3 describes virtual network
   overlays, *VXLAN*, and the
   role of overlays in the Cloud.
-  Refactored topics across Sections 4.1 (*Global Internet*) and 4.2
   (*IP Version 6*).   
-  New Perspective Section in Chapter 4 describes how the *Cloud*
   impacts the Internet’s structure.
-  Section 5.2 expanded to include a discussion of *QUIC*.
-  Section 5.3 expanded to include a description of *gRPC*.
-  Sections 6.3 and 6.4 updated to include descriptions of *TCP CUBIC,
   DCTCP,* and *BBR*.
-  Section 6.4 expanded to include a description of *Active Queue
   Management* (AQM).
-  Section 7.1 expanded to include a description of *Protocol Buffers*.
-  Section 7.2 expanded to include a description of *HTTP Adaptive
   Streaming*.
-  New Section 8.1 introduces the duality of *Threats* and *Trust*.
-  Refactored topics across Sections 8.3 (*Key Predistribution*) and
   8.4 (*Authentication Protocols*).
-  New Perspective Section in Chapter 8 describes *Decentralized
   Identity Management* and the role of *Blockchains*.
-  Section 9.1 updated to include a description of *HTTP/2*, along with
   a discussion of *REST*, *gRPC*, and *Cloud Services*.
-  Section 9.3 expanded to include a description of modern *Network
   Management Systems* including the use of *OpenConfig* and *gNMI*.

Organization
------------

To construct a networking course around the material in this book, it
can be helpful to understand the overall organization, which can be
characterized as having three major parts:

* Conceptual and foundational material, that is, the big ideas at the
  heart of networking.

* Core protocols and algorithms that illustrate how the foundational
  ideas are put to practice.

* Advanced material that might or might not fit in any single semester
  course.

This characterization can be applied at the Chapter level: Chapter 1
is foundational, Chapters 2, 3, 5, and 9 are core, and Chapters 4, 6,
7, and 8 cover more advanced topics.

This characterization can also be applied at the Section level, where
roughly speaking, each Chapter advances from basic concepts to
specific technology to advanced techniques. For example, Chapter 3
starts by introducing the basics of switched networks (3.1), then
covers the specifics of Switched Ethernet and the IP Internet
(3.2-3.4), and concludes with an optional discussion of SDN
(3.5). Similarly, Chapter 6 starts with foundational ideas (6.1-6.2),
then explores TCP congestion control (6.3), and concludes with
optional advanced material (6.4-6.5).

Code Examples
-------------

Since the first edition of this book, we have used code examples to
illustrate how various protocols and algorithms might be
implemented. Originally, the code came from the $x$-kernel, a
framework for protocol implementation and research developed in the
1990s, and you could compile and run every code fragment in the
book. As the $x$-kernel code is no longer maintained, we no longer
check that all the code in the book compiles or runs. At this point
the code should only be used as a guide to assist the reader in
understanding the topic at hand.

Acknowledgments
----------------

We would like to acknowledge the following people for their help with
new content:

-  Larry Brakmo: TCP Congestion Control
-  Carmelo Cascone: Bare-Metal Switches
-  Charles Chan: Bare-Metal Switches
-  Jude Nelson: Decentralized Identity
-  Oguz Sunay: Cellular Networks
-  Thomas Vachuska: Network Management

Along with the following individuals (GitHub users) for their various
contributions and bug fixes:

.. hlist::
   :columns: 3

   -  Mohammed Al-Ameen
   -  Mike Appelman 
   -  Andy Bavier
   -  Manuel Berfelde
   -  Brian Bohe
   -  John Craton      
   -  Peter DeLong
   -  Aaron Gember-Jacobson
   -  Chris Goldsworthy
   -  John Hartman
   -  Ethan Lam
   -  Diego López León
   -  Matteo Scandolo (teone)
   -  Mike Wawrzoniak
   -  罗泽轩 (spacewander)
   -  Arnaud (arvdrpoo)
   -  Desmond (kingdido999)
   -  Guo (ZJUGuoShuai)
   -  Hellman (eshellman)
   -  Xtao (vertextao)
   -  Joep (joepeding) 
   -  Seth (springbov)      
   -  miluchen (miluchen)
   -  Takashi Idobe (Takashiidobe)
   -  Beth (Innominata88)
   -  Mohit Mayank (mmynk)
   -  Mark Liffiton (liffiton)
   -  Junhao Zhang (junhaoim)
   -  Cooper Vandiver (CooperVandiver)
   -  Waheed Hafez (WaheedHafez)
   -  Benjamin Levy (BenjaminLevy)
   -  Takashi Idobe (Takashiidobe)
   -  Kirby Linvill (klinvill)
   -  Osman Karaketir (karaketir16)
   -  Anderson Adon (Anderson-A)
   -  李俊康 (lijunkang12)
   -  Yihao Wang (y1hao)

Finally, we would like to thank the following reviewers for their many
helpful comments and suggestions. Their impact was significant.

- Mark J. Indelicato, Rochester Institute of Technology 
- Michael Yonshik Choi, Illinois Institute of Technology
- Sarvesh Kulkarni, Villanova University
- Alexander L. Wijesinha, Towson University

Open Source
-----------

Source for this book is available at
https://github.com/SystemsApproach/book, and is available under terms of
the Creative Commons (CC BY 4.0) license. The community is invited to
contribute corrections, improvements, updates, and new material under
the same terms.  Like many open source software projects, this one has
been seeded with once restricted content: the fifth edition of
Peterson and Davie, copyrighted by Elsevier. Our hope is that open
sourcing this material will both make it widely available and serve as
an attractor for new content: updating what’s already there, expanding
it to cover new topics, and augmenting the text with additional
teaching collateral.

If you make use of this work, the attribution
should include the following information:

|  Title: *Computer Networks: A Systems Approach*
|  Authors: Larry Peterson and Bruce Davie
|  Copyright: Elsevier, 2012
|  Source: https://github.com/SystemsApproach/book
|  License: `CC BY  4.0 <https://creativecommons.org/licenses/by/4.0>`__


How to Contribute
-----------------

We hope that, if you use this
material, you are also willing to contribute back to it. If you are
new to open source, you might check out this How to Contribute to Open
Source (https://opensource.guide/how-to-contribute) guide. Among other
things, you’ll learn about posting Issues that you’d like to see
addressed, and issuing Pull Requests to merge your improvements back
into GitHub.  We hope you’ve derived value from Computer Networks: A
Systems Approach over the years, and we’re eager to have you join us
in this new venture.


| Larry & Bruce 
| October 2020


