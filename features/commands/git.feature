Feature: Manage vimpack git repo

  As a vimpack user
  I want manage my vimpack git repo
  So I can easily replicate my vimpack

  @wip
  Scenario: Initialize git remote
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack git remote add origin git@github.com:bramswenson/vimpack-repo.git"
    Then the exit status should be 0
      And the vimpack git remote "origin" should be "git@github.com:bramswenson/vimpack-repo.git"
