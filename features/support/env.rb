require 'aruba/cucumber'
require 'vimpack'

Before do
  @dirs = ["/tmp/aruba"]
  @aruba_timeout_seconds = 60
end

