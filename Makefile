# Makefile for building rockymeza.com
# by Rocky Meza

SCSS=sass --scss
STRANGE_CASE=scase

RIGHTNOW=$(shell date +'%c')

BUILDDIR=_site
SRCDIR=site

# static variables
STATICPREFIX=$(BUILDDIR)/static

CSS_DIR=$(STATICPREFIX)/css
CSS_SOURCES=$(wildcard semantic.gs/*css) $(wildcard css/*.scss) $(wildcard uikit/*.css)
CSS_TARGETS=$(CSS_DIR)/screen.css

IMAGE_DIR=$(STATICPREFIX)/image
IMAGE_SOURCES=$(wildcard image/*)
IMAGE_TARGETS=$(addprefix $(STATICPREFIX)/,$(IMAGE_SOURCES))

JS_DIR=$(STATICPREFIX)/js
JS_SOURCES=$(wildcard uikit/*.js) $(wildcard js/*)
JS_TARGETS=$(JS_DIR)/r.js

# site variables
LAYOUT_SOURCES=$(wildcard layouts/*)
SITE_SOURCES=$(wildcard $(SRCDIR)/*)


.PHONY: all
all: build

.PHONY: build
build: site collectstatic


# Ensure all directories
$(BUILDDIR): $(SITE_SOURCES) $(LAYOUT_SOURCES)
	$(STRANGE_CASE)

$(STATICPREFIX):
	mkdir $@

$(JS_DIR) $(CSS_DIR) $(IMAGE_DIR): $(STATICPREFIX)
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

$(JS_TARGETS): $(JS_SOURCES)
	cat $^ > $@

.PHONY: js
js: $(JS_DIR) $(JS_TARGETS)

.PHONY: collectstatic watch-static
collectstatic: $(CSS_TARGETS) $(IMAGE_TARGETS) $(JS_TARGETS)

watch-static:
	watchmedo shell-command --command='make collectstatic' --patterns='*.js;*css' --recursive


.PHONY: site watch-site
site: $(BUILDDIR)

watch-site:
	watchmedo shell-command --command='make site' --patterns='*.md;*.jinja' --recursive


.PHONY: serve
serve:
	cd $(BUILDDIR); python -m SimpleHTTPServer



.PHONY: deploy
deploy:
	cd $(BUILDDIR); git add .; git commit -m '$(RIGHTNOW)'; git push origin master

# cleanup
.PHONY: clean clean-static
clean:
	rm -r $(BUILDDIR)/*
clean-static:
	rm -r $(STATICPREFIX)
