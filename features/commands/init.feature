Feature: Initialize vimpack

  As a vimpack user
  I want to initialize vimpack
  So I can have a sane way to manage vim scripts

  Scenario: Initialize vimpack in an existing vim environment
    Given a directory named "test_vimpack/.vim"
      And an empty file named "test_vimpack/.vimrc"
      And "test_vimpack" is my home directory
    When I run "vimpack init"
    Then the output should contain " * backing up existing vim environment"
      And a directory named "test_vimpack/.vim.before_vimpack" should exist
      And a file named "test_vimpack/.vimrc.before_vimpack" should exist
    Then the output should contain " * initializing vimpack repo"
      And a directory named "test_vimpack/.vimpack" should exist and be a git repo
      And a directory named "test_vimpack/.vimpack/vim" should exist
      And a directory named "test_vimpack/.vimpack/vim/autoload" should exist
      And a directory named "test_vimpack/.vimpack/vim/bundle" should exist
      And a symlink named "test_vimpack/.vim" should exist and link to "test_vimpack/.vimpack/vim"
    Then the output should contain " * initializing pathogen"
      And a directory named "test_vimpack/.vimpack/pathogen" should exist and be a git submodule of "test_vimpack/.vimpack"
      And a symlink named "test_vimpack/.vimpack/vim/autoload/pathogen.vim" should exist and link to "test_vimpack/.vimpack/pathogen/plugin/pathogen.vim"
    Then the output should contain " * initializing .vimrc"
      And a symlink named "test_vimpack/.vimrc" should exist and link to "test_vimpack/.vimpack/vimrc"
    Then the output should contain "vimpack initialized!"

