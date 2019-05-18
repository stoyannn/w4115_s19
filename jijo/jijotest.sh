#/bin/bash

eval `opam config env`

rm ./jijoruntime.ll
rm ./tests/*.ll
rm ./tests/*.native
ocamlbuild -clean

clang-6.0 -S -emit-llvm ./jijoruntime.c -o ./jijoruntime.ll
ocamlbuild -use-ocamlfind ./jijo.native -package llvm

find ./tests/*.jj -exec sh -c './jijo.native $0 `dirname "$0"`/`basename "$0" .jj`.ll' '{}' \;
find ./tests/*.ll -exec sh -c 'llvm-link $0 ./jijoruntime.ll -o `dirname "$0"`/`basename "$0" .ll`.native' '{}' \;
find ./tests/*.native -exec chmod u+x {} \;

