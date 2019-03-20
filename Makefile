.PHONY: lint test

lint:
	@./check_command shellcheck 'https://www.shellcheck.net' && shellcheck git_clone_find

test:
	@./check_command bats 'https://github.com/sstephenson/bats' && bats git_clone_find.bats
