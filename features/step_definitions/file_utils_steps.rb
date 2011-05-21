def check_git_repo(path)
  prep_for_fs_check do
    res = %x{ cd #{path} ; git status ; cd - }
    res.should_not match(/Not a git repo/)
  end
end

def check_git_submodule(submodule, repo)
  name = submodule.split('/')[-1]
  prep_for_fs_check do
    res = %x{ cd #{repo} ; git submodule ; cd - }
    res.should match(/#{name}/)
  end
end

Then /^a directory named "([^"]*)" should exist and be a git repo$/ do |directory|
  check_directory_presence([directory], true)
  check_git_repo(directory)
end

Then /^a symlink named "([^"]*)" should exist and link to "([^"]*)"$/ do |link, target|
  File.should exist(File.join(@dirs, link))
  require 'pathname'
  Pathname.new(File.join(@dirs, link)).realpath.to_s.gsub('/private', '').should == File.join(@dirs, target)
end

Then /^a symlink named "([^"]*)" should not exist$/ do |link|
  File.exists?(File.join(@dirs, link)).should be_false
end

Then /^a directory named "([^"]*)" should exist and be a git submodule of "([^"]*)"$/ do |submodule, repo|
  check_directory_presence([repo], true)
  check_directory_presence([submodule], true)
  check_git_submodule(submodule, repo)
end

