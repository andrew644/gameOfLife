#!/bin/sh
cd src
nim c --out:../gameOfLife -d:release --opt:speed gameOfLife.nim
rm -rf nimcache
cd ..

