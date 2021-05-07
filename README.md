# simple-immutable

Setup Instructions (run before attempting to prove anything):
```
git submodule update --init --recursive
touch include.mak
make deps
make kevm -j3
rm include.mak
make include.mak
```
