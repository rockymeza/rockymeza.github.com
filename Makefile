# Makefile for building rockymeza.com
# by Rocky Meza

SCSS=sass --scss
STRANGE_CASE=python /home/rocky/projects/StrangeCase/strange_case.py

BUILDDIR=_site
SRCDIR=site

# static variables
STATICPREFIX=$(BUILDDIR)/static

CSS_DIR=$(STATICPREFIX)/css
CSS_SOURCES=$(wildcard semantic.gs/*css) $(wildcard css/*.scss)
CSS_TARGETS=$(CSS_DIR)/screen.css

IMAGE_DIR=$(STATICPREFIX)/image
IMAGE_SOURCES=$(wildcard image/*)
IMAGE_TARGETS=$(addprefix $(STATICPREFIX)/,$(IMAGE_SOURCES))

# site variables
LAYOUT_SOURCES=$(wildcard layouts/*)
SITE_SOURCES=$(wildcard $(SRCDIR)/*)


.PHONY: all
all: build

.PHONY: build
build: site collectstatic


# Ensure all directories
$(BUILDDIR): $(SITE_SOURCES) $(LAYOUT_SOURCES)
	echo $^
	$(STRANGE_CASE)

$(STATICPREFIX):
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


.PHONY: site
site: $(BUILDDIR)


.PHONY: deploy
deploy:
	cd $(BUILDDIR)
	git commit -am 'build site'
	git push origin master


# cleanup
.PHONY: clean clean-static
clean:
	rm -r $(BUILDDIR)/*
clean-static:
	rm -r $(STATICPREFIX)
