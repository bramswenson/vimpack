Feature: Install a vim script

  As a vimpack user
  I want to install a vim script
  So I can use it in vim

  Scenario: Install a script
    Given an initialized vimpack in "./"
    When I run `vimpack install rails.vim --trace`
    Then the output should contain:
      """
       * installing rails.vim
      """
    And the output should contain "rails.vim ("
    And the output should contain "installed!"
    And a directory named ".vimpack/scripts/utility/rails.vim" should exist and be a git submodule of ".vimpack"
    And a symlink named ".vimpack/vim/bundle/rails.vim" should exist and link to ".vimpack/scripts/utility/rails.vim"
    And the exit status should be 0

  Scenario: Install multiple scripts
    Given an initialized vimpack in "./"
    When I run `vimpack install rails.vim cucumber.zip`
    Then the output should contain:
      """
       * installing rails.vim
      """
    And the output should contain:
      """
       * installing cucumber.zip
      """
    And the output should contain "rails.vim ("
    And the output should contain "cucumber.zip ("
    And the output should contain "installed!"
    And a directory named ".vimpack/scripts/utility/rails.vim" should exist and be a git submodule of ".vimpack"
    And a symlink named ".vimpack/vim/bundle/rails.vim" should exist and link to ".vimpack/scripts/utility/rails.vim"
    And the exit status should be 0

  Scenario: Attempt to install a script that is not found
    Given an initialized vimpack in "./"
    When I run `vimpack install railz`
    Then the output should contain:
      """
      Script not found!
      """
    And the exit status should be 1

  Scenario: Attempt to install a script that is not found but a fuzzy match is found
    Given an initialized vimpack in "./"
    When I run `vimpack install cucumber`
    Then the output should contain:
      """
      Script not found! Did you mean cucumber.zip?
      """
    And the exit status should be 1

  Scenario: Install a script from a github repo directly
    Given an initialized vimpack in "./"
    When I run `vimpack install https://github.com/tpope/vim-rails`
    Then the output should contain:
      """
       * installing vim-rails
      """
    And the output should contain "vim-rails ("
    And the output should contain ") installed!"
    And a directory named ".vimpack/scripts/github/tpope/vim-rails" should exist and be a git submodule of ".vimpack"
    And a symlink named ".vimpack/vim/bundle/vim-rails" should exist and link to ".vimpack/scripts/github/tpope/vim-rails"
    And the exit status should be 0
