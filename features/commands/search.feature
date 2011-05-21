Feature: Search for a vim script

  As a vimpack user
  I want to search for a vim script
  So I can find a script to install

  Scenario: Search for a script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search rails`
    Then the output should contain:
      """
      rails.vim                        utility
      railscasts                       color scheme
      Railscasts-Theme-GUIand256color  color scheme
      railstab.vim                     utility
      FastGrep                         utility
      apidock.vim                      utility
      grails-vim                       utility
      paper                            color scheme
      """
      And the exit status should be 0

  Scenario: Search for a script within multiple script_types
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --utility --color-scheme rails`
    Then the output should contain:
      """
      rails.vim                        utility
      railscasts                       color scheme
      Railscasts-Theme-GUIand256color  color scheme
      railstab.vim                     utility
      FastGrep                         utility
      apidock.vim                      utility
      grails-vim                       utility
      paper                            color scheme
      """
      And the exit status should be 0

  Scenario: Search for a utility script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --utility rails`
    Then the output should contain:
      """
      rails.vim     utility
      railstab.vim  utility
      FastGrep      utility
      apidock.vim   utility
      grails-vim    utility
      """
      And the exit status should be 0

  Scenario: Search for all utility scripts
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --utility`
    Then the output should contain:
      """
      test.vim              utility
      test.zip              utility
      ToggleCommentify.vim  utility
      keepcase.vim          utility
      vimbuddy.vim          utility
      buffoptions.vim       utility
      fortune.vim           utility
      drawing.vim           utility
      ctags.vim             utility
      closetag.vim          utility
      """
      And the exit status should be 0

  Scenario: Search for a color scheme script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --color-scheme rails`
    Then the output should contain:
      """
      railscasts                       color scheme
      Railscasts-Theme-GUIand256color  color scheme
      paper                            color scheme
      """
      And the exit status should be 0

  Scenario: Search for a syntax script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --syntax haml`
    Then the output should contain:
      """
      haml.zip  syntax
      Haml      syntax
      """
      And the exit status should be 0

  Scenario: Search for an indent script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --indent ruby`
    Then the output should contain:
      """
      indentruby.vim     indent
      ruby.vim--IGREQUE  indent
      """
      And the exit status should be 0

  Scenario: Search for a game script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --game sudoku`
    Then the output should contain:
      """
      sudoku         game
      Sudoku-Solver  game
      """
      And the exit status should be 0

  Scenario: Search for a plugin script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --plugin apt`
    Then the output should contain:
      """
      apt-complete.vim  plugin
      """
      And the exit status should be 0

  Scenario: Search for a patch script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search --patch start`
    Then the output should contain:
      """
      startup_profile  patch
      """
      And the exit status should be 0

  Scenario: Search for an unknown script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development search this_does_not_exist_anywhere_right`
    Then the output should contain:
      """
      No scripts found!
      """
      And the exit status should be 0

