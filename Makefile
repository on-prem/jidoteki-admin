# Jidoteki Admin Makefile

.PHONY: all check run-tests

all:
		ansible-playbook jidoteki.yml -c local -i images.inventory -e prefix=$(PREFIX_DIR) --tags=admin -s -v

check: all run-tests

run-tests:
		JIDO_ADMIN_PATH=$(PREFIX_DIR)/opt/jidoteki/tinyadmin ./test.l
