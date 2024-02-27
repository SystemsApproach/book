About This Book
===============

Source for *Computer Networks: A Systems Approach* is available on
GitHub under terms of the `Creative Commons (CC BY 4.0)
<https://creativecommons.org/licenses/by/4.0>`__ license. The
community is invited to contribute corrections, improvements, updates,
and new material under the same terms.  While this license does not
automatically grant the right to make derivative works, we are keen to
discuss derivative works (such as translations) with interested
parties. Please reach out to discuss@systemsapproach.org.

Like many open source software projects, this one has been seeded with
once restricted content: the 5th edition of *Peterson and Davie*,
copyrighted by Elsevier. Our hope is that open sourcing this material
will both make it widely available and serve as an attractor for new
content: updating what’s already there, expanding it to cover new
topics, and augmenting the text with additional teaching collateral.

If you make use of this work, the attribution should include the
following information:

|  Title: *Computer Networks: A Systems Approach*
|  Authors: Larry Peterson and Bruce Davie
|  Copyright: Elsevier, 2012
|  Source: https://github.com/SystemsApproach/book
|  License: `CC BY  4.0 <https://creativecommons.org/licenses/by/4.0>`__

Read the Book
-------------

This book is part of the `Systems Approach Series
<https://www.systemsapproach.org>`__, with an online version published
at https://book.systemsapproach.org.

To track progress and receive notices about new versions, you can follow
the project on
`Mastodon <https://discuss.systems/@SystemsAppr>`__. To read a running
commentary on how the Internet is evolving, and for updates on our writing projects, you can sign up for the
`Systems Approach newsletter <https://systemsapproach.org/newsletter/>`__.

Releases and Editions
---------------------

We release ever-changing open source content rather than publish fixed
books, although you can roughly equate v6.0 with a 6th Edition. Read the
:ref:`preface` to find out what’s new in this version. Note
that Morgan Kaufmann (Elsevier)  published the 6th edition of the
textbook based on a fork of v6.0, but going forward, open source
releases found here will not necessarily stay in sync with any future
published editions.

In general, ``master`` contains a coherent and internally consistent
version of the material. (If it were code, the book would build and
run.) New content under development is checked into branches until it
can be merged into ``master`` without breaking self-consistency. The web
version of the book available at https://book.systemsapproach.org is then
continuously generated from ``master``, corresponding to a typical
maintenance release (although we do not bother to tag it as such).

Minor releases (e.g., v6.1) are tagged whenever there is sufficient new
content to justify the effort. This happens quarterly, give-or-take, and
is primarily to create a snapshot so that everyone in a course can know
they are using the same version.

Build the Book
--------------

To build a web-viewable version, you first need to download the
source:

.. code:: shell

   $ mkdir ~/systemsapproach
   $ cd ~/systemsapproach
   $ git clone https://github.com/systemsapproach/book.git
   $ cd book

The build process is stored in the ``Makefile`` and requires Python be
installed. The ``Makefile`` will create a virtualenv (``venv-docs``) which
installs the documentation generation toolset.  You may also need to
install the ``enchant`` C library using your system’s package manager
for the spelling checker to function properly.

To generate HTML in ``_build/html``,  run ``make html``.

To check the formatting of the book, run ``make lint``.

To check spelling, run ``make spelling``. If there are additional
words, names, or acronyms that are correctly spelled but not in the dictionary,
please add them to the ``dict.txt`` file.

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
(CLA) <https://github.com/SystemsApproach/book/blob/master/CLA.rst>`__.
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
