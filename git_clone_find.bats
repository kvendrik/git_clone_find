#!/usr/bin/env bats

source ./git_clone_find

git() { echo "git $1 $2 $3"; }
cd() { echo "cd $1"; }

@test "Help Flag: prints help message when --help flag is given" {
  run git_clone_find --help
  [ $(expr "${lines[0]}" : "Usage:.*") -ne 0 ]
}

@test "Help Flag: prints help message when -h flag is given" {
  run git_clone_find -h
  [ $(expr "${lines[0]}" : "Usage:.*") -ne 0 ]
}

@test "SSH URLs: supports cloning using simple ssh urls" {
  run git_clone_find git@github.com:kvendrik/dotfiles.git
  [ $(expr "${lines[0]}" : "git clone git@github.com:kvendrik/dotfiles.git*") -ne 0 ]
}

@test "SSH URLs: uses the repository name as the default folder name" {
  run git_clone_find git@github.com:kvendrik/dotfiles.git
  [ $(expr "${lines[0]}" : ".*dotfiles$") -ne 0 ]
}

@test "SSH URLs: allows specifing a custom folder name" {
  run git_clone_find git@github.com:kvendrik/dotfiles.git my_clone_folder
  [ $(expr "${lines[0]}" : ".*my_clone_folder$") -ne 0 ]
}

@test "SSH URLs: changes into the default directory when done" {
  run git_clone_find git@github.com:kvendrik/dotfiles.git
  [ "${lines[1]}" == "cd dotfiles" ]
}

@test "SSH URLs: changes into the custom directory when done" {
  run git_clone_find git@github.com:kvendrik/dotfiles.git my_clone_folder
  [ "${lines[1]}" == "cd my_clone_folder" ]
}

@test "Repository ID: supports cloning using a repository ID" {
  run git_clone_find kvendrik/dotfiles
  [ $(expr "${lines[1]}" : "git clone git@github.com:kvendrik/dotfiles.git*") -ne 0 ]
}

@test "Repository ID: logs information about interpretation of repository ID" {
  run git_clone_find kvendrik/dotfiles
  [ $(expr "${lines[0]}" : "Trying git@github.com:kvendrik/dotfiles.git.*") -ne 0 ]
}

@test "Repository ID: logs information about the folder we're cloning into" {
  run git_clone_find kvendrik/dotfiles
  [ $(expr "${lines[0]}" : ".*Cloning into dotfiles") -ne 0 ]
}

@test "Repository ID: uses the repository name as the default folder name" {
  run git_clone_find kvendrik/dotfiles
  [ $(expr "${lines[1]}" : ".*dotfiles$") -ne 0 ]
}

@test "Repository ID: allows specifing a custom folder name" {
  run git_clone_find kvendrik/dotfiles my_clone_folder
  [ $(expr "${lines[1]}" : ".*my_clone_folder$") -ne 0 ]
}

@test "Repository ID: changes into the default directory when done" {
  run git_clone_find kvendrik/dotfiles
  [ "${lines[2]}" == "cd dotfiles" ]
}

@test "Repository ID: changes into the custom directory when done" {
  run git_clone_find kvendrik/dotfiles my_clone_folder
  [ "${lines[2]}" == "cd my_clone_folder" ]
}

@test "Repository name: throws an error if GCF_GITHUB_USERNAMES is not set" {
  unset GCF_GITHUB_USERNAMES
  run git_clone_find dotfiles
  [ "$output" == "Repository identifier is non-specific and GCF_GITHUB_USERNAMES is not defined." ]
}

@test "Repository name: logs information about interpretation of repository name" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find dotfiles
  [ $(expr "${lines[0]}" : "Trying git@github.com:kvendrik/dotfiles.git.*") -ne 0 ]
}

@test "Repository name: logs information about the folder we're cloning into" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find dotfiles
  [ $(expr "${lines[0]}" : ".*Cloning into dotfiles") -ne 0 ]
}

@test "Repository name: tries to clone from all given usernames" {
  export GCF_GITHUB_USERNAMES=('kvendrik' 'my_org' 'my_org2')
  git() { echo "git $1 $2 $3"; $(exit 1); }
  run git_clone_find -v dotfiles
  [ "${lines[1]}" == "git clone git@github.com:kvendrik/dotfiles.git dotfiles" ]
  [ "${lines[3]}" == "git clone git@github.com:my_org/dotfiles.git dotfiles" ]
  [ "${lines[5]}" == "git clone git@github.com:my_org2/dotfiles.git dotfiles" ]
}

@test "Repository name: uses custom folder name for each try" {
  export GCF_GITHUB_USERNAMES=('kvendrik' 'my_org' 'my_org2')
  git() { echo "git $1 $2 $3"; $(exit 1); }
  run git_clone_find -v dotfiles my_custom_folder
  [ "${lines[1]}" == "git clone git@github.com:kvendrik/dotfiles.git my_custom_folder" ]
  [ "${lines[3]}" == "git clone git@github.com:my_org/dotfiles.git my_custom_folder" ]
  [ "${lines[5]}" == "git clone git@github.com:my_org2/dotfiles.git my_custom_folder" ]
}

@test "Repository name: displays error message with actionable item when all tries fail" {
  export GCF_GITHUB_USERNAMES=('kvendrik' 'my_org' 'my_org2')
  git() { $(exit 1); }
  run git_clone_find dotfiles
  [ "${lines[3]}" == "dotfiles could not be cloned. This usually means the repository could not be found. Run the command again with the --verbose flag for more info." ]
}

@test "Repository name: hides git clone ouput by default" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find dotfiles
  [ "${lines[1]}" != "git clone git@github.com:kvendrik/dotfiles.git dotfiles" ]
}

@test "Repository name: shows git clone ouput when --verbose flag is given" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find --verbose dotfiles
  [ "${lines[1]}" == "git clone git@github.com:kvendrik/dotfiles.git dotfiles" ]
}

@test "Repository name: shows git clone ouput when -v flag is given" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find -v dotfiles
  [ "${lines[1]}" == "git clone git@github.com:kvendrik/dotfiles.git dotfiles" ]
}

@test "Repository name: changes into the directory when done" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find dotfiles
  [ "${lines[1]}" == "cd dotfiles" ]
}

@test "Repository name: allows for a custom directory name" {
  export GCF_GITHUB_USERNAMES=('kvendrik')
  run git_clone_find dotfiles my_clone_folder
  [ $(expr "${lines[0]}" : ".*Cloning into my_clone_folder") -ne 0 ]
  [ "${lines[1]}" == "cd my_clone_folder" ]
}
