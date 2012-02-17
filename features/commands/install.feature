Feature: Install a vim script

  As a vimpack user
  I want to install a vim script
  So I can use it in vim

  Scenario: Install a script
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development install rails.vim`
    Then the output should contain:
      """
       * installing rails.vim
      rails.vim (4.4) installed!
      """
      And a directory named "test_vimpack/.vimpack/scripts/utility/rails.vim" should exist and be a git submodule of "test_vimpack/.vimpack"
      And a symlink named "test_vimpack/.vimpack/vim/bundle/rails.vim" should exist and link to "test_vimpack/.vimpack/scripts/utility/rails.vim"
      And the exit status should be 0

  Scenario: Install multiple scripts
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development install rails.vim cucumber.zip`
    Then the output should contain:
      """
       * installing rails.vim
      rails.vim (4.4) installed!
       * installing cucumber.zip
      cucumber.zip (1.0) installed!
      """
      And a directory named "test_vimpack/.vimpack/scripts/utility/rails.vim" should exist and be a git submodule of "test_vimpack/.vimpack"
      And a symlink named "test_vimpack/.vimpack/vim/bundle/rails.vim" should exist and link to "test_vimpack/.vimpack/scripts/utility/rails.vim"
      And the exit status should be 0

  Scenario: Attempt to install a script that is not found
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development install railz`
    Then the output should contain:
      """
      Script not found!
      """
      And the exit status should be 1

  Scenario: Attempt to install a script that is not found but a fuzzy match is found
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development install cucumber`
    Then the output should contain:
      """
      Script not found! Did you mean cucumber.zip?
      """
      And the exit status should be 1

  Scenario: Install a script from a github repo directly
    Given an initialized vimpack in "test_vimpack"
    When I run `vimpack -e development install https://github.com/tpope/vim-rails`
    Then the output should contain:
      """
       * installing vim-rails
      vim-rails (1599eecc7105971409d041e5acfe0fa85b23a097) installed!
      """
      And a directory named "test_vimpack/.vimpack/scripts/github/tpope/vim-rails" should exist and be a git submodule of "test_vimpack/.vimpack"
      And a symlink named "test_vimpack/.vimpack/vim/bundle/vim-rails" should exist and link to "test_vimpack/.vimpack/scripts/github/tpope/vim-rails"
      And the exit status should be 0
