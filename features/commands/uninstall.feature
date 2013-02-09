Feature: Uninstall a vim script

  As a vimpack user
  I want to uninstall a vim script
  So its not taking up space

  Scenario: Uninstall a script
    Given an initialized vimpack in "./"
     And "rails.vim" is already installed
    When I successfully run `vimpack uninstall rails.vim --trace`
    Then the output should contain:
      """
       * uninstalling rails.vim
      rails.vim uninstalled!
      """
      And a symlink named ".vimpack/vim/bundle/rails.vim" should not exist
      And a directory named ".vimpack/scripts/utility/rails.vim" should not exist
      And the exit status should be 0

  Scenario: Uninstall multiple scripts
    Given an initialized vimpack in "./"
     And "rails.vim" is already installed
     And "cucumber.zip" is already installed
    When I successfully run `vimpack uninstall rails.vim cucumber.zip`
    Then the output should contain:
      """
       * uninstalling rails.vim
      rails.vim uninstalled!
       * uninstalling cucumber.zip
      cucumber.zip uninstalled!
      """
    And a symlink named ".vimpack/vim/bundle/rails.vim" should not exist
    And a directory named ".vimpack/scripts/utility/rails.vim" should not exist
    And a symlink named ".vimpack/vim/bundle/cucumber.zip" should not exist
    And a directory named ".vimpack/scripts/utility/cucumber.zip" should not exist
    And the exit status should be 0

  Scenario: Try Uninstall a script that is not installed
    Given an initialized vimpack in "./"
    When I run `vimpack uninstall rails.vim --trace`
    Then the output should contain:
      """
      Script not found!
      """
    And the exit status should be 1

