
test: dist/bundle.lib.js dist/bundle.spec.js \
	vendor/coffee-script.js \
	vendor/jasmine/lib/jasmine-2.1.3/jasmine.js
	open spec/index.html

example: dist/bundle.lib.js
	open examples/bundle.html

api:
	open "http://localhost:3000/api/diagrams?data=%40found%20%22You%22%2C%20-%3E%0A%20%20%40message%20%22Think%22%2C%20-%3E%0A%20%20%20%20%40message%20%22Write%20your%20idea%22%2C%20%22JUMLY%22%2C%20-%3E%0A%20%20%20%20%20%20%40create%20%22Diagram%22%0Ajumly.css%20%22background-color%22%3A%22%238CC84B%22"

dist/bundle.lib.js dist/bundle.spec.js: node_modules/.bin/webpack lib/js/*.coffee spec/*.coffee
	webpack

vendor/coffee-script.js:
	mkdir -p vendor && cd vendor; \
	curl -OL http://coffeescript.org/extras/coffee-script.js

node_modules/jquery/dist/jquery.js:
	npm install

vendor/jasmine/lib/jasmine-2.1.3/jasmine.js:
	mkdir -p vendor/jasmine && cd vendor/jasmine; \
	curl -OL 'https://raw.githubusercontent.com/jasmine/jasmine/master/dist/jasmine-standalone-2.1.3.zip'; \
	unzip -o jasmine-standalone-2.1.3.zip; \
	touch lib/jasmine-2.1.3/jasmine.js

karma: vendor/coffee-script.js node_modules/jquery/dist/jquery.js
	karma start karma.conf.js

jasmine-node:
	NODE_PATH=node_modules:lib/js jasmine-node --coffee spec/*.coffee

clean:
	rm -rf build dist
