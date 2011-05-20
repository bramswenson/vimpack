module Vimpack
  module Utils
    module Vimscripts

      def self.included(base)
        base.send(:include, Vimpack::Utils::Api)
        base.send(:extend,  ClassMethods)
      end

      module ClassMethods

        def vimscripts_url
          'http://vim-scripts.org/api/scripts_recent.json'
        end

        def vimscripts
          # {"n"=>"test.vim", "t"=>"utility", "s"=>"example utility script file -- used for testing vimonline", "rv"=>"1.0", "rd"=>"2001-05-28", "ra"=>"Scott Johnston", "re"=>"scrott@users.sourceforge.net"}
          @vimscripts ||= Yajl.load(wrap_open(vimscripts_url))
          @vimscripts.clone
        end

        def search_vimscripts(q)
          q = q.downcase
          results = vimscripts.delete_if do |vimscript|
            !(vimscript['n'].downcase.include?(q) or vimscript['s'].downcase.include?(q))
          end
          results.each.map do |script|
            normalize_vimscript(script)
          end
        end

        def get_vimscript(name)
          results = vimscripts.delete_if do |vimscript|
            !(vimscript['n'] == name)
          end
          normalize_vimscript(results.first) rescue nil
        end

        def normalize_vimscript(script)
          { :name => script['n'], :script_type => script['t'],
            :description => script['s'], :script_version => script['rv'],
            :author => script['ra'], :author_email => script['re']
          }
        end

      end
    end
  end
end
