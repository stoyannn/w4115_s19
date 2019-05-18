#/bin/bash
eval `opam config env`
clang-6.0 -S -emit-llvm jijoruntime.c
ocamlbuild -clean
ocamlbuild -use-ocamlfind jijo.native -package llvm
./jijo.native ./tests/test.jj > ./tests/test.ll
chmod u+x ./tests/test.native
llvm-link ./tests/test.ll ./jijoruntime.ll -o ./tests/test.native
./tests/test.native
