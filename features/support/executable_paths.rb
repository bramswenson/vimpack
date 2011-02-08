#module ArubaOverrides
#  def detect_ruby_script(cmd)
#    puts "CMD IS: #{cmd}"
#    if cmd =~ /^vimpack /
#      lib_path = File.join(File.dirname(__FILE__), '..', '..', 'lib')
#      cmd_path = File.join(File.dirname(__FILE__), '..', '..', 'bin', cmd)
#      puts "RUNNING VIMPACK!"
#      "ruby -I#{lib_path} -S #{cmd_path}"
#    else
#      super(cmd)
#    end
#  end
#end
#
#World(ArubaOverrides)
