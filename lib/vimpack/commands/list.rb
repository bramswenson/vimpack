module Vimpack
  module Commands
    class List < Command

      def run
        Vimpack::Models::Repo.installed_scripts.each do |script|
          say(script.name)
        end
      end

    end
  end
end

