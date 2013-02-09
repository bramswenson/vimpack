Given /^an initialized vimpack in "([^"]*)"$/ do |homedir|
  steps %Q{
    Given a directory named "#{homedir}/.vim"
      And an empty file named "#{homedir}/.vimrc"
      And "#{homedir}" is my home directory
    When I successfully run `vimpack init`
    Then the output should contain "vimpack initialized!"
  }
end

Given /^"([^"]*)" is already installed$/ do |script_name|
  steps %Q{ Given I successfully run `vimpack install #{script_name}` }
end

