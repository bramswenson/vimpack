module Vimpack
  module Commands
    class Init < Command
      def initialize_commands
        die!("init takes a single optional argument") if @commands.size > 1
        @repo_url = @commands.size == 1 ? @commands[0] : nil
      end

      def run
        say(start_message)
        Vimpack::Models::Repo.initialize!(@repo_url)
        say('vimpack initialized!')
      end

      private

        def start_message
          " * initializing vimpack repo#{@repo_url.nil? ? '' : " from #{@repo_url}"}"
        end

    end
  end
end
