# Makefile for ONF documentation created with Sphinx

# use bash for pushd/popd, and to fail quickly. virtualenv's activate
# has undefined variables, so no -u
SHELL = bash -e -o pipefail

# You can set these variables from the command line.
SPHINXOPTS   ?=
SPHINXBUILD  ?= sphinx-build
SOURCEDIR    ?= .
BUILDDIR     ?= _build

# Create the virtualenv with all the tools installed
VIRTUALENV    = venv-docs

# Put it first so that "make" without argument is like "make help".
help: $(VIRTUALENV)
	source ./$(VIRTUALENV)/bin/activate ;\
  $(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help lint reload Makefile test

# Create the virtualenv with all the tools installed
$(VIRTUALENV):
	python3 -m venv $@ ;\
  source ./$@/bin/activate ;\
  pip install -r requirements.txt

# lint and link verification. linkcheck is built into sphinx
test: lint spelling linkcheck

# lint all .rst files
lint: $(VIRTUALENV)
	source ./$</bin/activate ;\
  doc8 --ignore-path $< --ignore-path _build --max-line-length 120 .

# clean up
clean:
	rm -rf "$(BUILDDIR)"

# clean-all - delete the virtualenv too
clean-all: clean
	rm -rf "$(VIRTUALENV)"

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: $(VIRTUALENV) Makefile
	source ./$</bin/activate ; set -u;\
  $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
