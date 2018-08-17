# Contributing

Contributors are encouraged to discuss major contributions (e.g., significant
rewrites or new sections/chapters) on the `discuss@systemsapproach.org`
mailing list before putting in a lot of effort. The first step is to
[join the forum](https://groups.google.com/a/systemsapproach.org/forum/#!forum/discuss).

Also, while GitHub is a great place to archive and track revisions over time,
it is often the case that a shared Google Document is a better tool for
collaboration. This is true not only for from-scratch efforts, but
also as a way to get comments and feedback on a fairly complete
draft. If you're game, we have a shared
[Google Drive Folder](https://drive.google.com/drive/u/2/folders/1diDcXKTyMFyuR7g1M6gTRuCnHXAUYj7C?ths=true).

If you have new material that doesn't fit into the current book
organization in an obvious way, check it into one of the following
repositories:

* [sdn](https://github.com/SystemsApproach/sdn): Sections or articles
  related to Software-Defined Networking.

* [cloud](https://github.com/SystemsApproach/cloud): Sections or
  articles related to cloud networking, both how Internet protocols
  have been adapted to work in data centers and how the cloud has
  impacted the greater Internet.

* [tools](https://github.com/SystemsApproach/tools): Tutorials or user
  guides describing diagnostic, monitoring, visualization, or analysis
  tools that can be used to gain insight into the how the Internet
  works in practice.

* [advanced-topics](https://github.com/SystemsApproach/advanced-topics):
  Sections or articles on any other advanced topic.

This is likely a stop-gap solution. We'll figure out the best way to
organize material (both old and new) over time. 

As for stylistic guidelines, there are only a few things to keep in mind.

First, try to keep each major topic (what corresponded to a chapter in
the original textbook) self-contained, with minimal forward- or
backward-references to other material. The idea is that each chapter
should be able to stand alone. (Think self-contained software module
with no hard-coded dependencies.)

Second, adhere to best practices using MarkDown. Run `make lint` on any
new text you write. See
https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
for the rules being applied. This may seem pedantic, but it's
important that the raw MarkDown be easily read, edited, and compared.

> **Note:** We're relaxed the "No Inline HTML" rule (MD033) to allow
> for the current treatment of Figures and Tables. This will
> eventually be corrected, and we suggest otherwise abiding by the
> rule.

Third, when creating figures, reuse as many of the existing graphical
elements as possible and stick to the current color scheme. Check in
both editable source (currently `.eps`) and a PNG file (300 dpi) for each
figure.

Finally, keep the *Systems Approach* in mind as you write. To quote the
Preface in the original book:

> **Approach**
>
> For an area that's as dynamic and changing as computer
> networks, the most important thing a textbook can offer is
> perspective—to distinguish between what's important and what's not,
> and between what's lasting and what's superficial. Based on our
> experience over the past 25-plus years doing research that has led to new
> networking technology, teaching undergraduate and graduate students
> about the latest trends in networking, and delivering advanced
> networking products to market, we have developed a perspective—which
> we call the *systems approach*—that forms the soul of this
> book. The systems approach has several implications:
>
> * *First Principles.* Rather than accept existing artifacts as gospel, we 
> start with first principles and walk you through the thought process that 
> led to today's networks. This allows us to explain *why* networks look
> like they do.  It is our experience that once you understand the
> underlying concepts, any new protocol that you are confronted with
> will be relatively easy to digest.
>
> * *Non-layerist.* Although the material is loosely organized around the 
> traditional network layers, starting at the bottom and moving up the 
> protocol stack, we do not adopt a rigidly layerist approach. Many
> topics—congestion control and security are good examples—have
> implications up and down the hierarchy, and so we discuss them outside
> the traditional layered model. Similarly, routers and switches have so
> much in common (and are often combined as single products) that we
> discuss them in the same chapter. In short, we believe layering makes a
> good servant but a poor master; it's more often useful to take an
> end-to-end perspective.
>
> * *Real-world Examples.* Rather than explain how protocols work in the 
> abstract, we use the most important protocols in use today—most of them 
> from the TCP/IP Internet—to illustrate how networks work in practice. This
> allows us to include real-world experiences in the discussion.
>
> * *Software.* Although at the lowest levels networks are constructed from
> commodity hardware that can be bought from computer vendors and
> communication services that can be leased from the phone company, it
> is the software that allows networks to provide new services and adapt
> quickly to changing circumstances.  It is for this reason that we
> emphasize how network software is implemented, rather than stopping
> with a description of the abstract algorithms involved. We also include
> code segments taken from a working protocol stack to illustrate how
> you might implement certain protocols and algorithms.
>
> * *End-to-end Focus.* Networks are constructed from many building-block
> pieces, and while it is necessary to be able to abstract away uninteresting
> elements when solving a particular problem, it is essential to
> understand how all the pieces fit together to form a functioning
> network. We therefore spend considerable time explaining the overall
> end-to-end behavior of networks, not just the individual components,
> so that it is possible to understand how a complete network operates,
> all the way from the application to the hardware.
>
> * *Performance.* The systems approach implies doing experimental
> performance studies, and then using the data you gather both to quantitatively
> analyze various design options and to guide you in optimizing the
> implementation. This emphasis on empirical analysis pervades the book.
>
> * *Design Principles.* Networks are like other computer
> systems—for example, operating 
> systems, processor architectures, distributed and parallel systems,
> and so on. They are all large and complex. To help manage this
> complexity, system builders often draw on a collection of design
> principles. We highlight these design principles as they are
> introduced throughout the book, illustrated, of course, with examples
> from computer networks.
