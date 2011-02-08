Given /^an initialized vimpack in "([^"]*)"$/ do |homedir|
  steps %Q{
    Given a directory named "#{homedir}/.vim"
      And an empty file named "#{homedir}/.vimrc"
      And "#{homedir}" is my home directory
    When I run "vimpack init"
    Then the output should contain "vimpack initialized!"
  }
end

