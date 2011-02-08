Feature: Search for a vim script

  As a vimpack user
  I want to search for a vim script
  So I can find a script to install

  Scenario: Initialize vimpack in an existing vim environment
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack search rails"
    Then the output should contain:
    """
      rails.vim                       utility    
      railscast                       colorscheme
      Railscast There (GUI&256color)  colorscheme
      railstab.vim                    utility    
      FastGrep                        utility
      apidock.vim                     utility
      grails-vim                      utility
    """
