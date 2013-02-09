Feature: Get information about a script

  As a vimpack user
  I want to get information about a vim script
  So I know more about what I am working with

  Scenario: Get script detailed information
    Given an initialized vimpack in "./"
    When I successfully run `vimpack info rails.vim`
    Then the output should contain:
      """
      Name: rails.vim
      Author: Tim Pope
      """
    And the output should contain:
      """
      Type: utility
      Description: Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more
      """
    And the exit status should be 0

  Scenario: Try to get info for a script that does not exist
    Given an initialized vimpack in "./"
    When I run `vimpack info this_does_not_exists_i_swear`
    Then the output should contain:
      """
      Script not found!
      """
      And the exit status should be 1

