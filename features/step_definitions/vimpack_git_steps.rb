def check_vimpack_remote(remote_name, url)
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git config -l ; cd - }
    res.should match(/remote.#{Regexp.escape(remote_name)}.url=#{Regexp.escape(url)}/)
  end
end

def check_vimpack_last_commit_log(message)
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git log -1 ; cd - }
    res.should match(/#{Regexp.escape(message)}/)
  end
end

def check_vimpack_status
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git status ; cd - }
    res.should match(/#{Regexp.escape('nothing to commit')}/)
  end
end

def initialize_git_repo(path)
  prep_for_fs_check do
    @full_path = File.join(File.expand_path(FileUtils.pwd), @path)
  end
  FileUtils.rmtree(@full_path).should be_true if File::directory?(@full_path)
  FileUtils.mkdir(@full_path).should be_true
  res = %x( git init --bare #{@full_path} )
  $?.should eq(0)
end


Then /^the vimpack git remote "([^"]*)" should be "([^"]*)"$/ do |remote_name, url|
  check_vimpack_remote(remote_name, url)
end

Then /^the vimpack git commit logs last message should be "([^"]*)"$/ do |message|
  check_vimpack_last_commit_log(message)
end

Then /^the vimpack git status should be empty$/ do
  check_vimpack_status
end

Given /^an initialized git repo in "([^"]*)"$/ do |path|
  @path = path
  @full_path = nil
  initialize_git_repo(@path)
end

Given /^an existing git repo in "([^"]*)"$/ do |path|
  steps %Q{
    Given an initialized git repo in "#{path}"
      And I run `vimpack -e development git remote add origin /tmp/aruba/#{path}`
    When I run `vimpack -e development git publish -m '[TEST] testing vimpack'`
    Then the exit status should be 0
      And the output should contain:
        """
         * publishing vimpack repo
        vimpack repo published!
        """
      And the vimpack git remote "origin" should be "/tmp/aruba/#{path}"
  }
end

Given /^an initialized vimpack in "([^"]*)" from remote "([^"]*)"$/ do |homedir, remote_path|
  steps %Q{
    Given a directory named "#{homedir}/.vim"
      And an empty file named "#{homedir}/.vimrc"
      And "#{homedir}" is my home directory
    When I run `vimpack -e development init /tmp/aruba/#{remote_path}`
    Then the exit status should be 0
      And the output should contain "vimpack initialized!"
      And the vimpack git remote "origin" should be "/tmp/aruba/#{remote_path}"
  }
end

Given /^an initialized vimpack in "([^"]*)" that is out of sync with its remote$/ do |path|
  steps %Q{
    Given an initialized vimpack in "#{path}"
      And "rails.vim" is already installed
      And an existing git repo in "vimpack-repo"
      And an initialized vimpack in "test_vimpack_remoted" from remote "vimpack-repo"
      And "#{path}" is my home directory
      And "cucumber.zip" is already installed
      And I run `vimpack -e development git publish -m '[CUKE] added cucumber.zip'`
      And "test_vimpack_remoted" is my home directory
      And "haml.zip" is already installed
  }
end

