SOURCE_FILES=$(shell `find source`)

build: config.rb $(SOURCE_FILES)
	middleman build

deploy: build
	cd build
	git add .
	git commit -am "`date +%F` deploy"
	git push origin master

.PHONY: deploy
