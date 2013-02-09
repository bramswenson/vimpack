require 'rspec/autorun'
require 'vimpack'
require 'fileutils'

def check_git_repo(path)
  res = %x{ ( cd #{path} ; git status ; cd - )2>&1 }
  res.should_not match(/Not a git repo/)
end

def check_git_submodule(submodule, repo)
  name = submodule.split('/')[-1]
  res = %x{ ( cd #{repo} ; git submodule ; cd - )2>&1 }
  res.should match(/#{name}/)
end

def check_vimpack_remote(remote_name, url)
  res = %x{ cd /tmp/vimpack_home/.vimpack ; git config -l ; cd - }
  res.should match(/remote.#{Regexp.escape(remote_name)}.url=#{Regexp.escape(url)}/)
end

HOME = '/tmp/vimpack_home'
REAL_HOME = ENV['HOME']
def remove_temp_home
  ::FileUtils.rm_rf(HOME) if ::File.exists?(HOME)
  ::FileUtils.mkdir(HOME)
end

def cp_netrc
  source = File.join(REAL_HOME, '.netrc')
  target = File.join(HOME, '.netrc')
  if File.exist?(source)
    FileUtils.cp(source, target)
    File.chmod(0600, target)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    ENV['HOME'] = HOME
  end
  config.before(:each) do
    remove_temp_home
    cp_netrc
  end
  config.after(:suite) do
    ENV['HOME'] = REAL_HOME
  end
end

