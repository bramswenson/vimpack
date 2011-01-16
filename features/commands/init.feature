Feature: Initialize vimpack

  As a vimpack user
  I want to initialize vimpack
  So I can have a sane way to manage vim scripts

  Scenario: Initialize vimpack in the an unconfigured environment
    Given a directory named "test_vimpack"
      And "test_vimpack" is my home directory
    When I run "vimpack init"
    Then the output should contain "vimpack initialized!"
      
      
