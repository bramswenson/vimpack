$LOAD_PATH.unshift(File.dirname(__FILE__), '..', '..', 'lib')
require 'vimpack'
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'aruba/cucumber'

Before do
  FileUtils.rmtree('/tmp/aruba')
  @dirs = ["/tmp/aruba"]
  @aruba_timeout_seconds = 60
end

