# Makefile for building rockymeza.com
# by Rocky Meza

SCSS=sass --scss
STRANGE_CASE=python /home/rocky/projects/StrangeCase/strange_case.py

BUILDDIR=_site
SRCDIR=site

# static variables
STATICPREFIX=$(BUILDDIR)/static

CSS_SOURCES=$(wildcard semantic.gs/*css) $(wildcard css/*.scss)
CSS_TARGETS=$(STATICPREFIX)/css/screen.css
CSS_DIR=$(STATICPREFIX)/css

IMAGE_SOURCES=$(wildcard image/*)
IMAGE_TARGETS=$(addprefix $(STATICPREFIX)/,$(IMAGE_SOURCES))
IMAGE_DIR=$(STATICPREFIX)/image

# site variables
LAYOUT_SOURCES=$(wildcard layouts/*)
SITE_SOURCES=$(wildcard $(SRCDIR)/*)
SITE_TARGETS=$(patsubst $(SRCDIR)%,$(BUILDDIR)%,$(subst jinja,html,$(SITE_SOURCES)))


.PHONY: all
all: build

.PHONY: build
build: site collectstatic


# Ensure all directories
$(BUILDDIR):
	mkdir $@

$(STATICPREFIX): $(BUILDDIR)
	mkdir $@

$(CSS_DIR) $(IMAGE_DIR): $(STATICPREFIX)
	mkdir $@


# static files
$(CSS_TARGETS): $(CSS_SOURCES)
	cat $^ | $(SCSS) > $@

.PHONY: css
css: $(CSS_DIR) $(CSS_TARGETS)

$(IMAGE_TARGETS): $(IMAGE_SOURCES)
	cp $^ $(IMAGE_DIR)

.PHONY: image
image: $(IMAGE_DIR) $(IMAGE_TARGETS)

.PHONY: collectstatic
collectstatic: $(STATICDIRS) $(CSS_TARGETS) $(IMAGE_TARGETS)


# StrangeCase
$(SITE_TARGETS): $(SITE_SOURCES) $(LAYOUT_SOURCES)
	$(STRANGE_CASE)

.PHONY: site
site: $(BUILDDIR) $(SITE_TARGETS)


# cleanup
.PHONY: clean clean-static
clean:
	rm -r $(BUILDDIR)
clean-static:
	rm -r $(STATICPREFIX)
