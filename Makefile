# Makefile for building rockymeza.com
# by Rocky Meza

SCSS=sass --scss
STRANGE_CASE=python /home/rocky/projects/StrangeCase/strange_case.py
PREFIX=_site
STATICPREFIX=_site/static/


CSS_SOURCES=$(wildcard semantic.gs/*css) $(wildcard css/*.scss)
CSS_TARGETS=$(STATICPREFIX)css/screen.css
IMAGE_SOURCES=$(wildcard image/*)
IMAGE_TARGETS=$(addprefix $(STATICPREFIX),$(IMAGE_SOURCES))


.PHONY: build
build: site collectstatic


# Ensure all directories
$(PREFIX):
	mkdir $(PREFIX)

$(STATICPREFIX): $(PREFIX)
	mkdir $(STATICPREFIX)
	mkdir $(STATICPREFIX)css
	mkdir $(STATICPREFIX)image
	mkdir $(STATICPREFIX)js


# static files
$(CSS_TARGETS): $(CSS_SOURCES)
	cat $^ | $(SCSS) > $@

.PHONY: css
css: $(STATICPREFIX) $(CSS_TARGETS)

$(IMAGE_TARGETS): $(IMAGE_SOURCES)
	cp $^ $(STATICPREFIX)image/

.PHONY: image
image: $(STATICPREFIX) $(IMAGE_TARGETS)

.PHONY: collectstatic
collectstatic: $(STATICPREFIX) $(CSS_TARGETS) $(IMAGE_TARGETS)

# StrangeCase
.PHONY: site
site: $(PREFIX) $(wildcard layouts/*.jinja) $(wildcard site/*.jinja)
	$(STRANGE_CASE)


.PHONY: clean clean-static
clean:
	rm -r $(PREFIX)
clean-static:
	rm -r $(STATICPREFIX)
