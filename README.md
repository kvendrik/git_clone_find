# git_clone_find

[![CircleCI](https://circleci.com/gh/kvendrik/git_clone_find.svg?style=svg)](https://circleci.com/gh/kvendrik/git_clone_find)

- Git clones and moves into the folder.
- Allows for simple `username/repo_name` syntax to clone (with Github).
- Allows for only a `repo_name` which will make it search through all your configured Github usernames.

<img src="https://github.com/kvendrik/git_clone_cd/raw/master/demo.gif" width="100%" />

## Setup

1. Clone this repository.
2. In your local rc file export all your preferred Github usernames (see help message) and source `git_clone_find`.
```bash
export GCF_GITHUB_USERNAMES=('kvendrik' 'my_org1' 'my_org2')
source path_to_this_repo/git_clone_find
```
3. (Optional) Add an alias of your choosing to your rc to make interacting with the CLI quicker.
```bash
alias gcf='git_clone_find'
```

## Help

```
Usage: git_clone_find [-v|--verbose|-h|--help] <ssh_url_or_repo_name> [<folder_name>]

Finds Git repositories, clones them and moves into the folder.

Flags:

  -h | --help                  Display this help message
  -v | --verbose               Verbose mode

Arguments:
  
  ssh_url_or_repo_name:        A SHH clone URL, repository name (will search through your set GCF_GITHUB_USERNAMES)
                               or repository identifier (e.g. kvendrik/dotfiles)
  folder_name:                 Name of the folder it should clone into. Defaults to the name of the repository.
```

## 🏗 Contibuting
1. Make your changes.
1. Run `make lint` to lint your changes and `make test` to test them.
1. Add the appropriate tests.
1. Create a PR.
