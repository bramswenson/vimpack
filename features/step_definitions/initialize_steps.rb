Given /^an initialized vimpack in "([^"]*)"$/ do |homedir|
  steps %Q{
    Given a directory named "#{homedir}/.vim"
      And an empty file named "#{homedir}/.vimrc"
      And "#{homedir}" is my home directory
    When I run "vimpack init"
    Then the output should contain "vimpack initialized!"
  }
end

Given /^"([^"]*)" is already installed$/ do |script_name|
  steps %Q{ Given I run "vimpack install #{script_name}" }
end

Given /^an initialized git repo in "([^"]*)"$/ do |path|
  @path = path
  FileUtils.rmtree(path).should be_true if File::directory?(path)
  FileUtils.mkdir(path).should be_true
  res = %x( git init --bare #{path} )
  $?.should eq(0)
end

