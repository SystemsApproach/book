# Release Notes

For a roadmap of ongoing and planned work, see the
[book wiki](https://github.com/SystemsApproach/book/wiki).

## February 25, 2019

This latest version is tagged `v5.3`. Major updates include:

* Added description of gRPC to [Section 5.3](https://github.com/SystemsApproach/e2e/blob/master/rpc.md)
* Added description of CUBIC to [Section 6.3](https://github.com/SystemsApproach/congestion/blob/master/tcpcc.md)
* Added descriptions of DCTCP and BBR to [Section 6.4](https://github.com/SystemsApproach/congestion/blob/master/avoidance.md)
* Added discussion of AQM and ECN to [Section 6.4](https://github.com/SystemsApproach/congestion/blob/master/avoidance.md)
* Added description of Protocol Buffers to [Section 7.1](https://github.com/SystemsApproach/data/blob/master/presentation.md)
* Added description of HTTP/2 to [Section 9.1](https://github.com/SystemsApproach/applications/blob/master/traditional.md)
 * Added discussion of REST, gRPC, and Cloud Services to [Section 9.1](https://github.com/SystemsApproach/applications/blob/master/traditional.md)

## December 31, 2018

This latest version is tagged `5.2`. It includes two major updates:

* Expanded discussion of fiber-to-the-home and 5G to [Section 2.8](https://github.com/SystemsApproach/direct/blob/master/access.md)
* Updated switch implementation description in [Section 3.4](https://github.com/SystemsApproach/internetworking/blob/master/impl.md)

This version also corrects many typos.

## October 5, 2018 

This latest version is tagged `5.1`. It is the result of a
front-to-back pass over the 5th edition, refreshing out-of-date
numbers, adding more timely and relevant examples, correcting
statements that were no longer valid, and fixing errors introduced
in translation from LaTeX to MarkDown. Minimal new content was
added (Section 2.8, on *Access Networks*, is the exception).

## August 16, 2018

The majority of the 5e content has been uploaded to github. Doing
so required non-trivial translation from **heavily** marked-up LaTex
to markdown, so there is a chance errors have been introduced. The
initial markdown is also fairly primitive.

The initial content excludes sidebars, most of the exercises, and all
of the book's front- and back-matter. We have permission to open
source those exercises that come with solutions, but doing so is still
pending.

There are two known issues:

* NPM sometimes fails during a build. Re-running `make` fixes it. 
* Math equations do not always render correctly on an initial view.
  Reloading the page fixes it. 

This initial version is tagged `5.0`.


