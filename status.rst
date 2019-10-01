Release Notes
=============

For a roadmap of ongoing and planned work, see the `book
wiki <https://github.com/SystemsApproach/book/wiki>`__.

August 1, 2019
--------------

This release is tagged ``v6.0``, which roughly equates with a 6th
Edition. Read the `Preface <preface.md>`__ to find out what’s new.

Note that Morgan Kaufmann (Elsevier) plans to publish a 6th edition of
their textbook based on a fork of this version. Going forward, open
source releases found here will not necessarily stay in sync with any
future published editions.

April 8, 2019
-------------

This latest version tagged ``v5.4``. Major updates include:

-  Added ``Broader Perspective`` (discussing cloudification) to the end
   of each chapter; linked starting with `Section
   1.8 <https://github.com/SystemsApproach/foundation/blob/master/trend.md>`__
-  Added overview of VXLAN to `Section
   3.5 <https://github.com/SystemsApproach/internetworking/blob/master/trend.md>`__
-  Added discussion of Cloud’s impact on Internet structure to `Section
   4.5 <https://github.com/SystemsApproach/scaling/blob/master/trend.md>`__
-  Added description of HTTP adaptive streaming to `Section
   7.2 <https://github.com/SystemsApproach/data/blob/master/multimedia.md>`__
-  Added new `Section
   8.1 <https://github.com/SystemsApproach/security/blob/master/trust.md>`__
   to discuss *threats* and *trust*
-  Added description of decentralized identity management to `Section
   8.6 <https://github.com/SystemsApproach/security/blob/master/trend.md>`__
-  Added description more recent management systems to `Section
   9.3 <https://github.com/SystemsApproach/applications/blob/master/infrastructure.md>`__

February 25, 2019
-----------------

This latest version is tagged ``v5.3``. Major updates include:

-  Added description of gRPC to `Section
   5.3 <https://github.com/SystemsApproach/e2e/blob/master/rpc.md>`__
-  Added description of CUBIC to `Section
   6.3 <https://github.com/SystemsApproach/congestion/blob/master/tcpcc.md>`__
-  Added descriptions of DCTCP and BBR to `Section
   6.4 <https://github.com/SystemsApproach/congestion/blob/master/avoidance.md>`__
-  Added discussion of AQM and ECN to `Section
   6.4 <https://github.com/SystemsApproach/congestion/blob/master/avoidance.md>`__
-  Added description of Protocol Buffers to `Section
   7.1 <https://github.com/SystemsApproach/data/blob/master/presentation.md>`__
-  Added description of HTTP/2 to `Section
   9.1 <https://github.com/SystemsApproach/applications/blob/master/traditional.md>`__
-  Added discussion of REST, gRPC, and Cloud Services to `Section
   9.1 <https://github.com/SystemsApproach/applications/blob/master/traditional.md>`__

December 31, 2018
-----------------

This latest version is tagged ``5.2``. It includes two major updates:

-  Expanded discussion of fiber-to-the-home and 5G to `Section
   2.8 <https://github.com/SystemsApproach/direct/blob/master/access.md>`__
-  Updated switch implementation description in `Section
   3.4 <https://github.com/SystemsApproach/internetworking/blob/master/impl.md>`__

This version also corrects many typos.

October 5, 2018
---------------

This latest version is tagged ``5.1``. It is the result of a
front-to-back pass over the 5th edition, refreshing out-of-date numbers,
adding more timely and relevant examples, correcting statements that
were no longer valid, and fixing errors introduced in translation from
LaTeX to MarkDown. Minimal new content was added (Section 2.8, on
*Access Networks*, is the exception).

August 16, 2018
---------------

The majority of the 5e content has been uploaded to github. Doing so
required non-trivial translation from **heavily** marked-up LaTex to
markdown, so there is a chance errors have been introduced. The initial
markdown is also fairly primitive.

The initial content excludes sidebars, most of the exercises, and all of
the book’s front- and back-matter. We have permission to open source
those exercises that come with solutions, but doing so is still pending.

There are two known issues:

-  NPM sometimes fails during a build. Re-running ``make`` fixes it.
-  Math equations do not always render correctly on an initial view.
   Reloading the page fixes it.

This initial version is tagged ``5.0``.
