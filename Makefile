# tinycore-scripts Makefile

PIL_MODULE_DIR ?= .modules
REPO_PREFIX ?= https://github.com/aw

JSON_REPO = $(REPO_PREFIX)/picolisp-json.git
JSON_DIR = $(PIL_MODULE_DIR)/picolisp-json/HEAD
JSON_REF ?= v3.2.0

SEMVER_REPO = $(REPO_PREFIX)/picolisp-semver.git
SEMVER_DIR = $(PIL_MODULE_DIR)/picolisp-semver/HEAD
SEMVER_REF ?= v0.10.0

# Unit testing
TEST_REPO = $(REPO_PREFIX)/picolisp-unit.git
TEST_DIR = $(PIL_MODULE_DIR)/picolisp-unit/HEAD
TEST_REF ?= v2.1.0

# Generic

.PHONY: all check run-tests

all:

$(JSON_DIR):
		mkdir -p $(JSON_DIR) && \
		git clone $(JSON_REPO) $(JSON_DIR) && \
		cd $(JSON_DIR) && \
		git checkout $(JSON_REF)

$(SEMVER_DIR):
		mkdir -p $(SEMVER_DIR) && \
		git clone $(SEMVER_REPO) $(SEMVER_DIR) && \
		cd $(SEMVER_DIR) && \
		git checkout $(SEMVER_REF)

$(TEST_DIR):
		mkdir -p $(TEST_DIR) && \
		git clone $(TEST_REPO) $(TEST_DIR) && \
		cd $(TEST_DIR) && \
		git checkout $(TEST_REF)

check: $(JSON_DIR) $(SEMVER_DIR) $(TEST_DIR) run-tests

run-tests:
		TC_LIB_PATH=$(shell pwd) PIL_NAMESPACES=false ./test.l
