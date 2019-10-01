# Makefile for ONF documentation created with Sphinx

# use bash for pushd/popd, and to fail quickly. virtualenv's activate
# has undefined variables, so no -u
SHELL = bash -e -o pipefail

# You can set these variables from the command line.
SPHINXOPTS   ?=
SPHINXBUILD  ?= sphinx-build
SOURCEDIR    ?= .
BUILDDIR     ?= _build

# Put it first so that "make" without argument is like "make help".
help: doc_venv
	source ./doc_venv/bin/activate ;\
	$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help lint reload Makefile test

# Create the virtualenv with all the tools installed
doc_venv:
	virtualenv doc_venv ;\
	source ./doc_venv/bin/activate ;\
	pip install livereload ;\
	pip install -r requirements.txt

# automatically reload changes in browser as they're made
reload: doc_venv
	source ./doc_venv/bin/activate ;\
	set -u ;\
	sphinx-reload $(SOURCEDIR)

# lint and link verification. linkcheck is built into sphinx
test: lint linkcheck

lint: rst-lint

rst-lint: doc_venv
	source ./doc_venv/bin/activate ;\
	set -u ;\
	rstcheck -r $$(find . -name \*.rst ! -path "*doc_venv*")

# clean up
clean:
	rm -rf $(BUILDDIR)

clean-all: clean
	rm -rf doc_venv

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile doc_venv | $(OTHER_REPO_DOCS)
	source ./doc_venv/bin/activate ;\
	set -u ;\
	$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
