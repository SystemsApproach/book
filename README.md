# Preface

This site contains source text for *Computer Networks: A Systems
Approach*, now available under the Creative Commons (CC BY) licensing
terms. The community is invited to contribute fixes, updates, and new
material under the same terms.

The material is organize as a git repository per chapter, with a
"root" repo (this one) containing the gitbook files needed to build a
full book. To build a web-viewable version, do the following:

```shell
mkdir systemsapproach
cd systemsapproach
git clone https://github.com/systemsapproach/book.git
cd book
git submodule init
git submodule update
```

then type

```shell
make
```

If all goes well, you will be able to view the book at
`localhost:4000`.

If you have fixes or updates you'd like to commit back to GitHub, do
that using `git` commands from the corresponding submodule
(directory). For example, to fix a typo in `chapter1/README.md` do the
following:

```shell
cd chapter1
...edit README.md...
git add README.md
git commit -c "fixed typo"
git push
```

This will typically result in a "pull request" that someone with write
permission on the repo (initially authors-now-editors Larry Peterson
and Bruce Davie) will need to approve. Over time, we hope to grow the
set of contributors that have write premission on one or more
repos/chapters. 

If you'd like to contribute and are looking for something that needs
work, see the [Project
Board](https://github.com/orgs/SystemsApproach/projects/).

We'd also like to expand the set of topics/chapters beyond the initial
set inherited from the 5th edition. If you have ideas, we'd love to
hear from you.

Finally, one bit of legalese. To contibute you need to first sign and
submit a Contributor Licensing Agreement (CLA). It's pretty
straightforward, establishing that what you contribute is available to
everyone else under the same terms as what others have contributed.
