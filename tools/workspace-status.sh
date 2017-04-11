#!/bin/bash

function rev() {
  cd $1; git describe --always --match "v[0-9].*" --dirty
}

echo STABLE_BUILD_PRINTY_LABEL $(rev .)
