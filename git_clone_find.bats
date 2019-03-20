#!/usr/bin/env bats

source ./git_clone_find

@test "prints help message when --help flag is given" {
  run git_clone_find --help
  [ $status -eq 0 ]
  [ $(expr "${lines[0]}" : "Usage:.*") -ne 0 ]
}

@test "prints help message when -h flag is given" {
  run git_clone_find -h
  [ $status -eq 0 ]
  [ $(expr "${lines[0]}" : "Usage:.*") -ne 0 ]
}
