module Vimpack
  module Commands
    class List < Command

      def run
        Dir.glob(self.script_path.join('*')).each do |script_dir|
          script_name = ::File.split(script_dir)[-1]
          say(script_name) unless script_name == 'pathogen.vim'
        end
      end

    end
  end
end

