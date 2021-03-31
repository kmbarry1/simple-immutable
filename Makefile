KLAB_OUT=out
export KLAB_OUT

PATH := $(CURDIR)/deps/klab/bin:$(CURDIR)/deps/evm-semantics/.build/usr/bin:$(PATH)
export PATH

KLAB_EVMS_PATH=$(CURDIR)/deps/evm-semantics
export KLAB_EVMS_PATH

DAPP_DIR=$(CURDIR)/dapp

.PHONY: all dapp kevm klab spec gen-spec gen-gas clean

all: deps include.mak

include.mak: src/specs.md
	klab make > include.mak

include include.mak

deps: dapp kevm klab

dapp:
	git submodule update --init --recursive -- dapp
	cd ./dapp && dapp --use solc:0.6.12 build && cd ../

kevm:
	git submodule update --init --recursive -- deps/evm-semantics
	cd deps/evm-semantics/                               \
		&& make deps RELEASE=true SKIP_HASKELL=true      \
		&& make build-java build-lemmas RELEASE=true -j4

klab:
	git submodule update --init --recursive -- deps/klab
	cd deps/klab/                   \
		&& npm install

specs/%.k: $(KLAB_OUT)/built/%
	cp $(KLAB_OUT)/specs/$$($(HASH) $*).k $@

specs/%.gas: $(KLAB_OUT)/gas/%.raw
	cp $< $@

gen-spec: $(patsubst %, specs/%.k, $(all_specs))
gen-gas:  $(patsubst %, specs/%.gas, $(pass_rough_specs))

dapp-clean:
	cd $(DAPP_DIR) && dapp clean && cd ../

clean: dapp-clean out-clean

out-clean:
	rm -rf $(KLAB_OUT)
