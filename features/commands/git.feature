Feature: Manage vimpack git repo

  As a vimpack user
  I want manage my vimpack git repo
  So I can easily replicate my vimpack

  Scenario: Publish vimpack to empty git repo
    Given an initialized vimpack in "test_vimpack"
      And an initialized git repo in "vimpack-repo"
      And I run "vimpack git remote add origin /tmp/aruba/vimpack-repo"
    When I run "vimpack git publish -m '[TEST] testing vimpack'"
    Then the exit status should be 0
      And the output should contain:
        """
         * commiting vimpack repo
        commited: [TEST] testing vimpack!
         * pushing vimpack repo
        vimpack repo pushed!
        """
      And the vimpack git remote "origin" should be "/tmp/aruba/vimpack-repo"

  Scenario: Publish vimpack repo when out of sync
    Given an initialized vimpack in "test_vimpack"
      And "rails.vim" is already installed
      And an existing git repo in "vimpack-repo"
      And an initialized vimpack in "test_vimpack_remoted" from remote "vimpack-repo"
      And "test_vimpack" is my home directory
      And "cucumber.zip" is already installed
      And I run "vimpack git publish -m '[CUKE] added cucumber.zip'"
      And "test_vimpack_remoted" is my home directory
      And "haml.zip" is already installed
    When I run "vimpack git publish -m '[TEST] this is a fail!'"
    Then the exit status should be 1
      And the output should contain:
        """
        error: local repo out of sync with remote
          use git to sync with something like this:
           vimpack git fetch && vimpack git merge origin/master
        """

  Scenario: Initialize vimpack git remote
    Given an initialized vimpack in "test_vimpack"
      And an initialized git repo in "vimpack-repo"
    When I run "vimpack git remote add origin /tmp/aruba/vimpack-repo"
    Then the exit status should be 0
      And the output should contain:
        """
         * running git remote add origin /tmp/aruba/vimpack-repo
        command ran: git remote add origin /tmp/aruba/vimpack-repo
        """
      And the vimpack git remote "origin" should be "/tmp/aruba/vimpack-repo"

  Scenario: Commit vimpack git repo with commit message
    Given an initialized vimpack in "test_vimpack"
      And an initialized git repo in "vimpack-repo"
      And I run "vimpack git remote add origin /tmp/aruba/vimpack-repo"
    When I run "vimpack git add . "
      And I run "vimpack git commit -m '[TEST] test commit'"
    Then the exit status should be 0
      And the output should contain:
        """
         * running git commit -m '[TEST] test commit'
        command ran: git commit -m '[TEST] test commit'
        """
      And the vimpack git commit logs last message should be "[TEST] test commit"

  Scenario: Publish vimpack git repo
    Given an initialized vimpack in "test_vimpack"
      And an initialized git repo in "vimpack-repo"
      And I run "vimpack git remote add origin /tmp/aruba/vimpack-repo"
      And "rails.vim" is already installed
    When I run "vimpack git publish"
    Then the exit status should be 0
      And the output should contain:
        """
         * pushing vimpack repo
        vimpack repo pushed!
        """
      And the vimpack git status should be empty
