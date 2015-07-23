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

# Run this Makefile with a copy of GNU Make:
#     <http://www.gnu.org/software/make/>
#
# Targets:
#     all (dtl): Compile DTL's erlang sources.
#     check (test, ct): Run DTL's test suite.
#     deps: Install all dependencies (requires `rebar').
#     doc: Build EDoc.
#     dialyze (dia): Run Dialyzer over the codebase, checking types and
#         things.
#     get-deps: Only download dependencies, don't build them.
#     plt: Build files necessary for running `dialyze'.
#
# Options:
#     DIALYZER: The path to the Dialyzer executable.
#     CT_RUN: The path to the Common Test executable.
#     CT_FLAGS: Extra options for Common Test.

SHELL := bash
PROGRAM = dtl
REBAR ?= ./rebar
DEPS = deps

all: deps dtl

./rebar:
	erl -noshell -s inets start -s ssl start \
		-eval 'httpc:request(get, {"https://raw.github.com/wiki/rebar/rebar/rebar", []}, [], [{stream, "./rebar"}])' \
		-s inets stop -s init stop
	chmod +x ./rebar


get-deps: $(REBAR) rebar.config
	$(REBAR) get-deps

deps: $(REBAR) get-deps
	$(REBAR) compile

MAIN_ERLS = $(shell find src -name '*.erl' -not -name '*tests.erl')

DIALYZER ?= dialyzer
DIALYZER_FLAGS ?=

CT_RUN ?= ct_run
CT_FLAGS = -pa $(TEST_APP)/ebin -pa $(DEPS)/*/ebin
CT_SUITES = eunit_SUITE

TEST_APP = test/eunit_SUITE_data/test_app

dtl: $(REBAR)
	$(REBAR) compile skip_deps=true

clean: $(REBAR) check-clean doc-clean
	$(REBAR) clean skip_deps=true
	$(MAKE) -C $(TEST_APP) clean

check: check-clean dtl
	$(MAKE) -C $(TEST_APP)
	mkdir -p logs
	$(CT_RUN) $(EFLAGS) $(CT_FLAGS) -pa ebin \
		-I include -dir test -logdir logs -suite $(CT_SUITES) \
		|| ( f="$$(find logs -name eunit_suite.eunit.html | head -1)" ; \
	if [[ -n "$$f" ]] ; then \
		echo ; echo "$$f" ; \
		[[ "$$(uname)" = Darwin ]] \
			&& open "file://$$PWD/$$f" \
			|| (hash firefox 2> /dev/null \
				&& firefox -new-window "file://$$PWD/$$f") ; \
	fi )
ct: check
test: check

check-clean:
	rm -rf logs

doc:
	mkdir -p doc
	./edoc.escript

doc-clean:
	rm -rf doc

plt:
	$(DIALYZER) --build_plt --output_plt .$(PROGRAM).plt \
		--apps kernel stdlib

dialyze:
	$(DIALYZER) $(DIALYZER_FLAGS) --apps $(DEPS)/*/ebin \
		--src $(MAIN_ERLS) --plt .$(PROGRAM).plt --no_native
dia: dialyze

.PHONY: all dtl clean check ct test check-clean doc doc-clean plt \
	dialyze dia
