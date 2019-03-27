# git_clone_find

[![CircleCI](https://circleci.com/gh/kvendrik/git_clone_find.svg?style=svg)](https://circleci.com/gh/kvendrik/git_clone_find)

- Allows for simple `username/repository_name` syntax to clone (with Github).
- Allows for only a repository name which will make it search through all your configured Github usernames.

<img src="https://github.com/kvendrik/git_clone_cd/raw/master/demo.gif" width="100%" />

## Setup

1. Clone this repository.
2. In your local rc file export all your preferred Github usernames (see help message) and add the repository directory to your `PATH`.
```bash
export GCF_USERNAMES='kvendrik my_org1 my_org2'
export PATH="$PATH:path_to_this_repo/git_clone_find"
```

### Advanced Options
If you'd like you can set up an alias to access the CLI quicker and move into the cloned directory when a clone succeeds. To do this add the following function to your local rc file:
```bash
gcf() {
  git_clone_find "$@" && 
  [ -d "$(git_clone_find --last-clone-path)" ] &&
  cd $(git_clone_find --last-clone-path)
}
```
When you do this make sure that your function name is not overwriting an existing function or alias.

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
