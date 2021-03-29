.PHONY: dapp kevm

dapp:
	git submodule update --init --recursive -- dapp
	cd ./dapp && dapp --use solc:0.6.12 build && cd ../

kevm:
	git submodule update --init --recursive -- deps/evm-semantics
	cd deps/evm-semantics/                               \
		&& make deps RELEASE=true SKIP_HASKELL=true      \
		&& make build-java build-lemmas RELEASE=true -j4
