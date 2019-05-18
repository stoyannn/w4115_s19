#/bin/bash

eval `opam config env`

rm ./jijoruntime.ll
rm ./tests/test.ll
rm ./tests/test.native
ocamlbuild -clean

clang-6.0 -S -emit-llvm ./jijoruntime.c -o ./jijoruntime.ll
ocamlbuild -use-ocamlfind ./jijo.native -package llvm
./jijo.native ./tests/test.jj > ./tests/test.ll
llvm-link ./tests/test.ll ./jijoruntime.ll -o ./tests/test.native
chmod u+x ./tests/test.native

./tests/test.native
