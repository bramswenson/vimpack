require 'aruba/cucumber'
require 'vimpack'

REAL_HOME = ENV['HOME']
def cp_netrc(dirs)
  source = File.join(REAL_HOME, '.netrc')
  target = File.join(dirs, '.netrc')
  if File.exist?(source)
    FileUtils.cp(source, target)
    File.chmod(0600, target)
  end
end

Before do
  @dirs = ["/tmp/aruba"]
  base_dir = File.join(*@dirs)
  FileUtils.rmtree(base_dir)
  FileUtils.mkdir_p(base_dir)
  cp_netrc(base_dir)
  @aruba_timeout_seconds = 60
end

