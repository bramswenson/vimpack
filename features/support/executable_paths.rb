module ArubaOverrides
  def detect_ruby_script(cmd)
    if cmd =~ /^torkt-cli/
      "ruby -I../../lib -S ../../bin/#{cmd}"
    else
      super(cmd)
    end
  end
end

World(ArubaOverrides)
