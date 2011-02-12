Feature: Install a vim script

  As a vimpack user
  I want to install a vim script
  So I can use it in vim

  @wip
  Scenario: Install a script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack install rails.vim"
    Then show me the output
    Then the output should contain:
      """
        * installing rails.vim
      rails.vim (4.3) installed!
      """
      And a directory named "test_vimpack/.vimpack/scripts/rails.vim" should exist and be a git submodule of "test_vimpack/.vimpack"
      And a symlink named "test_vimpack/.vimpack/vim/bundle/rails.vim" should exist and link to "test_vimpack/.vimpack/scripts/rails.vim"
      And the exit status should be 0
