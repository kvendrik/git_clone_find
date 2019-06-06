get_github_repositories_for_username() {
  curl -s https://api.github.com/users/$1/repos | grep -Eo "\"\w+\/[^\"]+\""
}

REPOS=($(curl -s https://api.github.com/users/kvendrik/repos | grep -Eo "\"\w+\/[^\"]+\""))
echo $REPOS

_git_clone_find_completions()
{
  for repo in "${REPOS[@]}"; do
    COMPREPLY+=("$repo")
  done
}

complete -F _git_clone_find_completions git_clone_find