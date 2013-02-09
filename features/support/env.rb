require 'aruba/cucumber'
require 'vimpack'

Before do
  @dirs = ["/tmp/aruba"]
  FileUtils.rmtree(File.join(*@dirs))
  FileUtils.mkdir_p(File.join(*@dirs))
  @aruba_timeout_seconds = 60
end

