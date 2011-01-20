Feature: Initialize vimpack

  As a vimpack user
  I want to initialize vimpack
  So I can have a sane way to manage vim scripts

  Scenario: Initialize vimpack in an existing vim environment
    Given a directory named "test_vimpack/.vim"
      And an empty file named "test_vimpack/.vimrc"
      And "test_vimpack" is my home directory
    When I run "vimpack init"
    Then the output should contain "vimpack initialized!"
      And the output should contain "backing up existing vim environment"
      And the output should contain "backing up existing .vim directory"
      And the output should contain "backing up existing .vimrc file"
      And a directory named "test_vimpack/.vim.before_vimpack" should exist
      And a file named "test_vimpack/.vimrc.before_vimpack" should exist
      And a directory named "test_vimpack/.vimpack" should exist
      And a directory named "test_vimpack/.vimpack/.vim" should exist
      And a directory named "test_vimpack/.vimpack/bundle" should exist
      And a file named "test_vimpack/.vimrc" should exist
      
      
