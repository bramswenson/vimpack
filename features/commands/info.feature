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

  Scenario: Try to get info for a script that does not exist
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack info this_does_not_exists_i_swear"
    Then the output should contain:
      """
      script not found!
      """
      And the exit status should be 1

