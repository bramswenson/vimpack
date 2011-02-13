Feature: Get information about a script

  As a vimpack user
  I want to get information about a vim script
  So I know more about what I am working with

  Scenario: Get script detailed information
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack info rails.vim"
    Then the output should contain:
      """
      Name: rails.vim
      Author: tpope
      Version: 4.3
      Type: utility
      Description:
      """
      And the exit status should be 0
