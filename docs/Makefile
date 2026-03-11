# Makefile for Sphinx + Dart API documentation

SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

# Dart API generator
DARTDOC_TOOL  = ../tool/dartdoc_to_md
REPO_ROOT     = ..

.PHONY: help clean html livehtml dartdoc html-python

help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	rm -rf $(BUILDDIR)
	rm -rf reference/dart_api

# Generate Dart API markdown using the custom analyzer-based generator
dartdoc:
	@echo "Generating Dart API documentation..."
	cd $(DARTDOC_TOOL) && dart run bin/generate.dart --root $(shell cd $(REPO_ROOT) && pwd) --output docs/reference/dart_api
	@echo "Dart API markdown generated in dart_api/"

# Build HTML docs (runs Dart generator first, then Sphinx)
html: dartdoc
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "Build finished. Open $(BUILDDIR)/html/index.html"

# Build HTML docs without Dart doc generation (faster for Python-only changes)
html-python:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "Build finished. Open $(BUILDDIR)/html/index.html"

livehtml:
	sphinx-autobuild "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS) $(O)
