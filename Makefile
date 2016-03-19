# Copyright (c) 2013- Thomas Allen <thomas@oinksoft.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Run this Makefile with a copy of GNU Make!
# <http://www.gnu.org/software/make/>

# Targets:
#     build: Compile DTL's erlang sources.
#     check: Run DTL's test suite.
#     deps: Install all dependencies (requires `rebar').
#     dialyze: Run Dialyzer over the codebase, checking types and things.
#     doc: Build EDoc.
#     get-deps: Only download dependencies, don't build them.
#     plt: Build files necessary for running `dialyze'.
#
# Options:
#     CT_BROWSER: A browser to display Common Test errors.
#     CT_FLAGS: Extra options for Common Test.
#     CT_RUN: The path to the Common Test executable.
#     DIALYZER: The path to the Dialyzer executable.

SHELL := bash
REBAR ?= rebar
DEPS = deps

MAIN_ERLS = $(shell find src -name '*.erl' -not -name '*tests.erl')

DIALYZER ?= dialyzer
DIALYZER_FLAGS ?=

CT_RUN ?= ct_run
CT_BROWSER ?= links
CT_FLAGS = -pa $(TEST_APP)/ebin -pa $(DEPS)/*/ebin

TEST_APP = test/eunit_SUITE_data/test_app

all: deps build

get-deps: rebar.config
	$(REBAR) get-deps

deps: get-deps
	$(REBAR) compile

build:
	$(REBAR) compile skip_deps=true

check: check-clean build
	$(MAKE) -C $(TEST_APP)
	mkdir -p logs
	$(CT_RUN) $(EFLAGS) $(CT_FLAGS) -pa ebin -I include -dir test -logdir logs \
		-suite eunit_SUITE \
		|| $(CT_BROWSER) "file://$$(find logs -name eunit_suite.eunit.html | head -1)"

doc:
	mkdir -p doc
	./edoc.escript

plt:
	$(DIALYZER) --build_plt --output_plt .dtl.plt \
		--apps kernel stdlib

dialyze:
	$(DIALYZER) $(DIALYZER_FLAGS) --apps $(DEPS)/*/ebin \
		--src $(MAIN_ERLS) --plt .dtl.plt --no_native

clean: check-clean doc-clean
	$(REBAR) clean skip_deps=true
	$(MAKE) -C $(TEST_APP) clean

check-clean:
	rm -rf logs

doc-clean:
	rm -rf doc

.PHONY: all build clean check check-clean doc doc-clean plt dialyze
