#!/bin/bash

function fgulp() {
  cd /projects/ctasites/webapp-dispatcher/src/main/webapp/WEB-INF/frontend/
  if [ -z $1 ]; then
    gulp default
  else
    gulp $1
  fi
  cd -
}