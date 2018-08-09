<!--- Copyright 2018, Larry Peterson & Bruce Davie    --->
<!--- Licsenced under the CC BY License, Version 4.0 --->
<!--- https://creativecommons.org/licenses/by/4.0  --->

# Preface 

This site contains source text for *Computer Networks: A Systems
Approach*, now available under terms of the [Creative Commons
(CC BY 4.0)](https://creativecommons.org/licenses/by/4.0)
license. The community is invited to contribute corrections,
improvements, updates, and new material under the same terms.

Like many open source software projects, this one has been seeded
with once proprietary content: the 5th edition of *Peterson and Davie*,
copyrighted by Elsevier. Our hope is that open sourcing this material
will not only make it widely available, but also serve as an attractor
for new content: updating what's already there, expanding it to
include additional topics, and augmenting the text with additional
teaching collateral.

We will initially play an editorial role—vetting and wordsmithing
contributions—but our plan is share ownership of the project with
others committed to its success.

## Getting Started

The material is organize as a git repository per chapter, each
of which focuses on a major networking topic (e.g., *Internetworking*,
*Congestion Control*). A "root" repo (this one) contains the gitbook
files that can be used to create a full book. To build a web-viewable
version, you first need to install a couple packages:

* [Gitbook Toolchain](https://toolchain.gitbook.com/setup.html)
* [Node.js Package Manager](https://www.npmjs.com/get-npm)

Then do the following to download the source:

```shell
mkdir ~/systemsapproach
cd ~/systemsapproach
git clone https://github.com/systemsapproach/book.git
cd book
git submodule init
git submodule update
```

To build the gitbook, simply type:

```shell
make
```

If all goes well, you will be able to view the book in your browser at
`localhost:4000`.

## How to Contribute

We hope that if you use this material, you are also willing to
contribute back to it. If you are new to open source, you might check
out this [How to Contribute to Open
Source](https://opensource.guide/how-to-contribute/) guide.
Among other things, you'll learn about posting *Issues* that you'd
like to see addressed, and issuing *Pull Requests* to merge your
improvements back into GitHub.

If you do want to contribute either patches or new material, you will
need to sign a [Contributor Licensing Agreement
(CLA)](https://github.com/SystemsApproach/book/blob/master/CLA.md).
There's nothing you need to do this minute; you'll be prompted to
sign the CLA the first time you make a pull request.

The CLA is pretty straightforward: it establishes that (a) you have
the right to contribute what you're contributing, and (b) what you
contribute is available to everyone else under the same
[CC BY](https://creativecommons.org/licenses/by/4.0) terms as
the existing content. The CLA is a little unusual in that it explicitly
calls out Elsevier's rights, but suffice it to say, the publishing
industry is still getting comfortable with open source.

You should also familiarize yourself with the [guidelines for
contributing](https://github.com/SystemsApproach/book/blob/master/CONTRIBUTING.md).
As a first step,  we recommend you check to see if any new text
you'd like to submit passes our `MarkDownLint` test. To do this,
run

```shell
cd ~/systemsapproach
make lint
```

Finally, if you'd like to contribute and are looking for something
that needs attention, see the current list of
[Issues](https://github.com/SystemsApproach/book/issues/)
or the [Project Board](https://github.com/orgs/SystemsApproach/projects/).
We'd also like to expand the set of topics/chapters beyond the initial
set inherited from the 5th edition, so if you have ideas, we'd love to
hear from you. Send email to `discuss@systemsapproach.org`, or better
yet, [join the
forum](https://groups.google.com/a/systemsapproach.org/forum/#!forum/discuss).

## Join Us

We hope you've gotten value out of *Computer Networks: A Systems
Approach* over the years, and we're eager to have you join us in this
new venture.

Larry Peterson & Bruce Davie  
August 8, 2018
