#!/usr/bin/env pil

(unless *Tc_functions_loaded
  (chdir (pack (if (sys "JIDO_ADMIN_PATH") @ "/opt/jidoteki/tinyadmin") "/lib")
    (load "tc-functions.l" ".modules/picolisp-unit/HEAD/unit.l") ) )

(let bye nil # don't let (bye) spoil our fun
  (chdir "tests/"
    (load "test_tc-functions.l") ) )

(report)
