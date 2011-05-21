Feature: Use different environments for vimpack

  As a vimpack user
  I want to use different environments
  Mostly so I can test vimpack

  Background: Setup test directories
    Given a directory named "test_vimpack/.vim"
      And an empty file named "test_vimpack/.vimrc"
      And "test_vimpack" is my home directory

  Scenario: Default environment should be production and should not alert
    When I run `vimpack init`
    Then the output should not contain " * using production environment!"
      And the exit status should be 0

  Scenario: When not in production environment we should be alerted
    When I run `vimpack --environment development init`
    Then the output should contain:
    """
     * using environment :development
    """
      And the output should not contain " * using production environment"
      And the exit status should be 0


