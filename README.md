# git_clone_cd

- Git clones and moves into the folder.
- Allows for simple `username/repo_name` syntax to clone (with Github).
- Allows for only a `repo_name` which will make it check all your configured Github usernames.

## Setup

1. Install through [Homebrew](https://brew.sh/).
```
brew install gccd
```

2. Export all your Github usernames in your local rc file.
```
export GCCD_GITHUB_USERNAMES=('kvendrik' 'my_org1' 'my_org2')
```

## Help

```
Usage: gccd [-v|--verbose|-h|--help] <ssh_url_or_repo_name> [<folder_name>]

Git clones and moves into the folder.

Flags:

  -h | --help                  Display this help message
  -v | --verbose               Verbose mode

Arguments:
  
  ssh_url_or_repo_name:        A SHH clone URL, repository name (will search through your set GITHUB_USERNAME
                               and GITHUB_ORGS_USERNAMES) or repository identifier (e.g. kvendrik/dotfiles)
  folder_name:                 Name of the folder it should clone into. Defaults to the name of the repository.
```