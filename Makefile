# Define the formatting command for all .gd files
format:
	gdformat $(shell find . -name '*.gd')

lint:
	gdlint $(shell find . -name '*.gd')
