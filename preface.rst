Preface
=======

It has been nearly ten years since the 5th Edition of *Computer
Networks: A Systems Approach* was published. Much has changed in that
time, most notably, the explosion of the cloud and smartphone apps onto
the scene. In many ways, this is reminiscent of the dramatic affect the
Web was having on the Internet when we published the 1st Edition of the
book in 1996.

The 6th Edition adapts to the times, but keeps the *Systems Approach*
as its north star. In broad strokes, we update and improve this new
edition in four main ways:

-  We refresh the examples to reflect the current state of the world.
   This includes deleting anachronisms (e.g., dial-up modem), using
   popular applications (e.g., Netflix, Spotify) to motivate the
   problems being addressed, and updating the numbers to represent the
   state-of-the-art technology (e.g., 10-Gbps Ethernet).

-  We connect the dots between the original research that led to the
   development of technologies like multicast, real-time video
   streaming, and quality-of-service, and the now-familar cloud
   applications like GoToMeeting, Netflix, and Spotify. This is in
   keeping with our emphasis on the design process and not just the
   end result, which is especially important today since so much the
   Internet is primarily available in proprietary commercial services.

- We place the Internet in the broader context of the Cloud, and just
  as importantly, in the context of the commerial forces that are
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
  
More specifically, the 6th Edition includes the following major changes:

-  New Perspective Section in Chapter 1 introduces the recurring
   *Cloudification* theme.
-  New Section 2.8 describes the *Access Network*, including Passive
   Optical Networks (PON) and 5G’s Radio Access Networks (RAN).
-  Section 3.2 rewritten to emphasize *Switched Ethernet*.
-  Section 3.5 updated to include descriptions of *White-Box Switches*
   and *Software-Defined Networks* (SDN).
-  New Perspective Section in Chapter 3 describes *VXLANs* and the
   role of overlays in the Cloud.
-  New Perspective Section in Chapter 4 describes how the *Cloud*
   impacts the Internet’s structure.
-  Section 5.2 expanded to include a discussion of *QUIC*.
-  Section 5.3 expanded to include a description of *gRPC*.
-  Sections 6.3 and 6.4 updated to include descriptions of *TCP CUBIC,
   DCTCP,* and *BBR*.
-  Section 6.4 expanded to include a description of *Active Queue
   Management* (AQM).
-  Section 7.1 expanded to include a desciption of *Protocol Buffers*.
-  Section 7.2 expanded to include a desciption of *HTTP Adaptive
   Streaming*.
-  New Section 8.1 introduces the duality of *Threats* and *Trust*.
-  New Perspective Section in Chapter 8 describes *Decentralized
   Identity Management* and the role of *Blockchains*.
-  Section 9.1 updated to include a description of *HTTP/2*, along with
   a discussion of *REST*, *gRPC*, and *Cloud Services*.
-  Section 9.3 expaned to include a description of modern *Network
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
(3.2-3.4), and concludes with an optional discusion of SDN
(3.5). Similarly, Chapter 6 starts with foundational ideas (6.1-6.2),
then explores TCP congestion control (6.3), and concludes with
optional advanced material (6.4-6.5).

Acknowledgements
----------------

We would like to acknowledge the following people for their help with
new content:

-  Larry Brakmo: TCP Congestion Control
-  Carmelo Cascone: White-Box Switches
-  Charles Chan: White-Box Switches
-  Jude Nelson: Decentralized Identity
-  Oguz Sunay: Cellular Networks
-  Thomas Vachuska: Network Management

Along with the following individuals (github users) for their various
contributions and bug fixes:

.. hlist::
   :columns: 3

   -  Mohammed Al-Ameen
   -  Andy Bavier
   -  Manuel Berfelde
   -  Chris Goldsworthy
   -  John Hartman
   -  Diego López León
   -  Matteo Scandolo
   -  Mike Wawrzoniak
   -  罗泽轩 (spacewander)
   -  Arnaud (arvdrpoo)
   -  Desmond (kingdido999)
   -  Guo (ZJUGuoShuai)
   -  Hellman (eshellman)
   -  Xtao (vertextao)

Finally, we would like to thank the following reviewers for their many
helpful comments and suggestions. Their impact was significant.

- Mark J. Indelicato, Rochester Institute of Technology 
- Michael Yonshik Choi, Illinois Institute of Technology
- Sarvesh Kulkarni, Villanova University
- Alexander L. Wijesinha, Towson University

| Larry & Bruce 
| November 2019 

