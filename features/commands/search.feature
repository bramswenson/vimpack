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

  Scenario: Search for a script within multiple script_types
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --utility --color-scheme rails"
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

  Scenario: Search for a utility script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --utility rails"
    Then the output should contain:
      """
      rails.vim     utility
      railstab.vim  utility
      FastGrep      utility
      apidock.vim   utility
      """
      And the exit status should be 0

  Scenario: Search for a color scheme script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --color-scheme rails"
    Then the output should contain:
      """
      railscasts                       color scheme
      Railscasts-Theme-GUIand256color  color scheme
      """
      And the exit status should be 0

  Scenario: Search for a syntax script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --syntax haml"
    Then the output should contain:
      """
      Haml      syntax
      haml.zip  syntax
      """
      And the exit status should be 0

  Scenario: Search for an indent script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --indent ruby"
    Then the output should contain:
      """
      ruby.vim--IGREQUE  indent
      indentruby.vim     indent
      """
      And the exit status should be 0

  Scenario: Search for a game script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --game sudoku"
    Then the output should contain:
      """
      sudoku         game
      Sudoku-Solver  game
      """
      And the exit status should be 0

  Scenario: Search for a plugin script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --plugin apt"
    Then the output should contain:
      """
      apt-complete.vim  plugin
      """
      And the exit status should be 0

  Scenario: Search for a patch script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search --patch start"
    Then the output should contain:
      """
      startup_profile  patch
      """
      And the exit status should be 0

  Scenario: Search for an unknown script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search this_does_not_exist_anywhere_right"
    Then the output should contain:
      """
      no scripts found!
      """
      And the exit status should be 0

