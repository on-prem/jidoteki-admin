(prinl "^J  Testing TinyCore scripts^J")

(setq
      *My_tests_are_order_dependent NIL )

[de APP_INFO
  ("name"      "test_tc-functions.l")
  ("version"   "0.0.3")
  ("summary"   "Unit tests'")
  ("source"    "https://github.com/on-prem/tinycore-scripts")
  ("author"    "Alexander Williams")
  ("license"   "MIT")
  ("copyright" "(c) 2016 Alexander Williams, Unscramble <license@unscramble.jp>") ]

[de APP_HELP
  ("usage"     "test.l")
  ("example"   "test.l")
  ("options"   ("--help"    "show this help message and exit")
               ("--version" "show the application version and exit") ]

[de error-codes
  ("TC0001"     "Invalid command line argument") ]

### tests

[de test-functions-loaded ()
  (assert-t             *Tc_functions_loaded
                        "Ensure all functions are loaded only once" ]

[de test-root-variable ()
  (assert-equal         "/"
                        *Root
                        "Ensure the *Root variable points to /" ]

[de test-tc-error-empty ()
  (assert-equal         '(("File" . "test_tc-functions.l") ("Code") ("Message") ("Details"))
                        (tc-error)
                        "Ensure tc-error returns a list with empty values" ]

[de test-tc-error-full ()
  (assert-equal         '(("File" . "test_tc-functions.l") ("Code" . "TC0001") ("Message" . "Invalid command line argument") ("Details" . "--testing"))
                        (tc-error "TC0001" "--testing")
                        "Ensure tc-error returns a list with filled values" ]

[de test-tc-error-stderr-empty ()
  (assert-nil           (err "/dev/null" (tc-error-stderr))
                        "Ensure tc-error-stderr returns nothing" ]

[de test-tc-error-stderr-full ()
  (assert-equal         "test_tc-functions.l: TC0001: Invalid command line argument: --testing"
                        (err "/dev/null" (tc-error-stderr (tc-error "TC0001" "--testing")))
                        "Ensure tc-error-stderr returns an error string" ]

[de test-tc-error-json-full ()
  (let Result
                  "{\"File\":\"test_tc-functions.l\",\"Code\":\"TC0001\",\"Message\":\"Invalid command line argument\",\"Details\":\"--testing\"}"
    (assert-equal       Result
                        (err "/dev/null" (tc-error-generic (encode (tc-error "TC0001" "--testing"))))
                        "Ensure tc-error-output returns an error string in JSON" ) ]

[de test-tc-show-version-empty ()
  (let APP_INFO NIL
    (assert-equal         " v^JCopyright ^JLicense "
                          (out "/dev/null" (tc-show-version))
                          "Ensure tc-show-version returns an 'empty' string" ]

[de test-tc-show-version-full ()
  (assert-equal         "test_tc-functions.l v0.0.3^JCopyright (c) 2016 Alexander Williams, Unscramble <license@unscramble.jp>^JLicense MIT"
                        (out "/dev/null" (tc-show-version))
                        "Ensure tc-show-version returns version info" ]

[de test-tc-show-options-empty ()
  (let APP_HELP NIL
    (assert-nil           (out "/dev/null" (tc-show-options))
                          "Ensure tc-show-options returns an 'empty' string" ]

[de test-tc-json-decode ()
  (let Json "{\"test\":\"string\"}"
    (assert-equal       (list (cons "test" "string"))
                        (decode Json)
                        "Ensure '(decode)' can decode a JSON string" ]

[de test-tc-json-encode ()
  (let Json (list (cons "test" "string"))
    (assert-equal       "{\"test\":\"string\"}"
                        (encode Json)
                        "Ensure '(encode)' can encode a JSON string" ]

[de test-tc-call-t ()
  (assert-t           (tc-call (list 'true))
                      "Ensure tc-call returns T when a command doesn't output to stderr" ]

[de test-tc-call-nil ()
  (assert-nil         (tc-call (list 'acommandthatdoesntexist))
                      "Ensure tc-call returns NIL when a command outputs to stderr" ]

[de test-tc-semver-satisfies ()
  (assert-t           (semver-satisfies "1.0.0" "1.0.0" "2.0.0")
                      "Ensure '(semver-satisfies)' can format, compare, sort a string") ]

[execute
  '(test-functions-loaded)
  '(test-root-variable)
  '(test-tc-error-empty)
  '(test-tc-error-full)
  '(test-tc-error-stderr-empty)
  '(test-tc-error-stderr-full)
  '(test-tc-show-version-empty)
  '(test-tc-show-version-full)
  '(test-tc-show-options-empty)
  '(test-tc-json-decode)
  '(test-tc-json-encode)
  '(test-tc-error-json-full)
  '(test-tc-call-t)
  '(test-tc-call-nil)
  '(test-tc-semver-satisfies) ]
