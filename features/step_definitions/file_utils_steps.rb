Then /^a directory named "([^"]*)" should exist and be a git repo$/ do |directory|
  check_directory_presence([directory], true)
  steps %Q{
    And I run "cd #{directory} && git status ; cd -"
    Then the output should not contain "Not a git repository"
  }
end

Then /^a symlink named "([^"]*)" should exist and link to "([^"]*)"$/ do |link, target|
  File.should exist(File.join(@dirs, link))
  require 'pathname'
  Pathname.new(File.join(@dirs, link)).realpath.to_s.should == File.join(@dirs, target)
end

Then /^a directory named "([^"]*)" should exist and be a git submodule of "([^"]*)"$/ do |submodule, repo|
  check_directory_presence([repo], true)
  check_directory_presence([submodule], true)
  name = submodule.split('/')[-1]
  steps %Q{
    And I run "cd #{repo} && git submodule ; cd -"
    Then the output should contain "#{name}"
  }
end

