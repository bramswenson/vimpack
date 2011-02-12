Feature: Uninstall a vim script

  As a vimpack user
  I want to uninstall a vim script
  So its not taking up space 

  Scenario: Uninstall a script
    Given an initialized vimpack in "test_vimpack"
     And "rails.vim" is already installed
    When I run "vimpack uninstall rails.vim"
    Then the output should contain:
      """
       * uninstalling rails.vim
      rails.vim uninstalled!
      """
      And a symlink named "test_vimpack/.vimpack/vim/bundle/rails.vim" should not exist
      And a directory named "test_vimpack/.vimpack/scripts/rails.vim" should not exist
      And the exit status should be 0
