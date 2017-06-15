#!/bin/bash

function _ql() {
  if [ -f $1 ] ; then
      qlmanage -p 2>/dev/null $1
  else
      echo "'$1' is not a valid file"
  fi
}

_ql $1
