Feature: Get information about a script

  As a vimpack user
  I want to get information about a vim script
  So I know more about what I am working with

  @wip
  Scenario: Get script detailed information
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack info rails.vim"
    Then the stdout should contain:
      """
      Name: rails.vim
      Author: Tim Pope
      Version: 4.3
      Description: Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more
      """
      And the exit status should be 0
