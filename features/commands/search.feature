Feature: Search for a vim script

  As a vimpack user
  I want to search for a vim script
  So I can find a script to install

  Scenario: Search for a script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search rails"
    Then the output should contain:
      """
      rails.vim                        utility
      railstab.vim                     utility
      railscasts                       color scheme
      Railscasts-Theme-GUIand256color  color scheme
      FastGrep                         utility
      apidock.vim                      utility
      """
      And the exit status should be 0

  @wip
  Scenario: Search for a utility script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --utility rails"
    Then the output should contain:
      """
      rails.vim                        utility
      railstab.vim                     utility
      FastGrep                         utility
      apidock.vim                      utility
      """
      And the exit status should be 0

