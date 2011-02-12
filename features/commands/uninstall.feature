Feature: Uninstall a vim script

  As a vimpack user
  I want to uninstall a vim script
  So its not taking up space 

  @wip
  Scenario: Uninstall a script
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack install rails.vim"
    Then show me the output
    Then the output should contain:
      """
      rails.vim uninstalled!
      """
      And a file named "test_vimpack/.vimpack/vim/bundle/rails.vim" should not exist
      And a directory named "test_vimpack/.vimpack/scripts/rails.vim" should not exist
      And the exit status should be 0
