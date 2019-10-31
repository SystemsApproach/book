About This Book
===============

This site contains source text for *Computer Networks: A Systems
Approach*, now available under terms of the `Creative Commons (CC BY
4.0) <https://creativecommons.org/licenses/by/4.0>`__ license. The
community is invited to contribute corrections, improvements, updates,
and new material under the same terms.

Like many open source software projects, this one has been seeded with
once restricted content: the 5th edition of *Peterson and Davie*,
copyrighted by Elsevier. Our hope is that open sourcing this material
will both make it widely available and serve as an attractor for new
content: updating what’s already there, expanding it to cover new
topics, and augmenting the text with additional teaching collateral.

We will initially play an editorial role (curating and wordsmithing) for
contributions that come back, but our plan is to share ownership of the
project with others committed to its success.

And if you make use of this work, the attribution should include the
following information:

|  Title: *Computer Networks: A Systems Approach*
|  Authors: Larry Peterson and Bruce Davie*
|  Copyright: Elsevier, 2012
|  Source: https://github.com/SystemsApproach
|  License: `CC BY  4.0 <https://creativecommons.org/licenses/by/4.0>`__

Read the Book
-------------

An online version of the book is published at
https://book.systemsapproach.org. You can also find a PDF version
`here <https://github.com/SystemsApproach/5G/releases>`__.

To track progress and receive notices about new versions, you can follow
the project on
`Facebook <https://www.facebook.com/Computer-Networks-A-Systems-Approach-110933578952503/>`__
and `Twitter <https://twitter.com/SystemsAppr>`__. To read a running
commentary on how the Internet is evolving, follow the `Systems Approach
Blog <https://www.systemsapproach.org>`__.

Releases and Editions
---------------------

We release ever-changing open source content rather than publish fixed
books, although you can roughly equate v6.0 with a 6th Edition. Read the
`Preface <preface.html>`__ to find out what’s new in this version. Note
that Morgan Kaufmann (Elsevier) plans to publish a 6th edition of their
textbook based on a fork of v6.0, but going forward, open source
releases found here will not necessarily stay in sync with any future
published editions.

In general, ``master`` contains a coherent and internally consistent
version of the material. (If it were code, the book would build and
run.) New content under development is checked into branches until it
can be merged into ``master`` without breaking self-consistency. The web
version of the book available at https://book.systemsapproach.org is
periodically generated from ``master``, and corresponds to a typical
maintenance release, although we do not bother to tag it as such (e.g.,
6.0.1).

Minor releases (e.g., v6.1) are tagged whenever there is sufficient new
content to justify the effort. This happens quarterly, give-or-take, and
is primarily to create a snapshot so that everyone in a course can know
they are using the same version. The off-line formats (e.g., pdf, epub)
are also generated with every minor release.

Build the Book
--------------

The source content is organized as a git repository per chapter, each of
which focuses on a major networking topic (e.g., *Internetworking*,
*Congestion Control*). A “root” repo (`this
one <https://github.com/SystemsApproach/book>`__) contains the
top-level files needed to assemble a full book.

To build a web-viewable version, you first need to download the source:

.. code:: shell

   mkdir ~/systemsapproach
   cd ~/systemsapproach
   git clone https://github.com/systemsapproach/book.git
   cd book
   git submodule init
   git submodule update

The build process is stored in the ``Makefile`` and requires Python be 
installed. The ``Makefile`` will create a virtualenv (``doc_venv``) which 
installs the documentation generation toolset. 

To generate HTML in ``_build/html``,  run ``make html``.

To get a live reload in your browser (refreshes on file save), run ``make reload``.

To check the formatting of the book, run ``make lint``.

To see the other available output formats, run ``make``.

How to Contribute
-----------------

We hope that if you use this material, you are also willing to
contribute back to it. If you are new to open source, you might check
out this `How to Contribute to Open
Source <https://opensource.guide/how-to-contribute/>`__ guide. Among
other things, you’ll learn about posting *Issues* that you’d like to see
addressed, and issuing *Pull Requests* to merge your improvements back
into GitHub.

If you do want to contribute either patches or new material, you will
need to sign a `Contributor Licensing Agreement
(CLA) <https://github.com/SystemsApproach/book/blob/master/CLA.md>`__.
You’ll be prompted to sign the CLA the first time you make a pull
request.

The CLA is pretty straightforward: it establishes that (a) you have the
right to contribute what you’re contributing, and (b) what you
contribute is available to everyone else under the same `CC
BY <https://creativecommons.org/licenses/by/4.0>`__ terms as the
existing content. The CLA is a little unusual in that it explicitly
calls out Elsevier’s rights (which are the same as everyone’s), but this
does signal their intent to continue publishing textbooks based on the
material.

You should also familiarize yourself with the `guidelines for
contributing <https://github.com/SystemsApproach/book/blob/master/CONTRIBUTING.rst>`__.

If you’d like to contribute and are looking for something that needs
attention, see the current `Project
Board <https://github.com/orgs/SystemsApproach/projects/>`__. We’d also
like to expand the set of topics/chapters beyond the initial set
inherited from the 5th edition, so if you have ideas, we’d love to hear
from you. Send email to ``discuss@systemsapproach.org``, or better yet,
`join the
forum <https://groups.google.com/a/systemsapproach.org/forum/#!forum/discuss>`__.

Finally, in as much as this is an on-going effort, we will try to record
and track our
`progress
<https://github.com/SystemsApproach/book/blob/master/status.rst>`__.
For now, think of this as a poor-man’s release notes. Additional
information about work-in-progress can be found in the
`wiki <https://github.com/SystemsApproach/book/wiki>`__.

Join Us
-------

We hope you’ve gotten value out of *Computer Networks: A Systems
Approach* over the years, and we’re eager to have you join us in this
new venture.

| Larry Peterson & Bruce Davie
| November 2019
