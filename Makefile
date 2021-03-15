.PHONY: dapp
dapp:
	git submodule update --init --recursive -- dapp
	cd ./dapp && dapp --use solc:0.6.12 build && cd ../
