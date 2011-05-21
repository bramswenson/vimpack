Feature: List installed vim script

  As a vimpack user
  I want to list installed vim script
  So I know what I am working with

  Scenario: List installed vim scripts
    Given an initialized vimpack in "test_vimpack"
     And "rails.vim" is already installed
     And "railscasts" is already installed
    When I run `vimpack -e development list`
    Then the stdout should contain:
      """
      rails.vim
      railscasts
      """
      And the exit status should be 0

