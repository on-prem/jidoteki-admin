#!/usr/bin/env pil

(load ".modules/picolisp-unit/HEAD/unit.l")

(let bye nil # don't let (bye) spoil our fun
  (chdir "tests/"
    (load "test_tc-functions.l") ) )

(report)
