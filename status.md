# Status

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

This initial version is tagged `v5.0`.

## August 23, 2018

Started a `refresh` branch for a low-hanging-fruit pass. The goal is
to fix egregiously out-of-date material without spending too much
time adding new content. Minor refactoring/renaming when appropriate.
May include minimal/placeholder subsections to be expanded later.
