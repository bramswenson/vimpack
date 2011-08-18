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

        def search_vimscripts(q, types = [], limit = 10, offset = 0)
          results = q.nil? ? vimscripts : search_for_string(q, vimscripts)
          results = types.empty? ? results : search_for_type(types, results)
          normalize_results(limit, offset, results)
        end

        def normalize_results(limit, offset, results)
          results[offset..limit-1].map do |script|
            normalize_vimscript(script)
          end
        end

        def search_for_type(types, results)
          results.delete_if do |vimscript|
            !types.include?(vimscript['t'])
          end
        end

        def search_for_string(q, results)
          q = q.downcase
          results.delete_if do |vimscript|
            !(vimscript['n'].downcase.include?(q) or vimscript['s'].downcase.include?(q))
          end
        end

        def get_vimscript(name)
          results = vimscripts.delete_if do |vimscript|
            !(vimscript['n'] == name)
          end
          normalize_vimscript(results.first) rescue nil
        end

        def normalize_vimscript(script)
          { :name => script['n'], :type => script['t'],
            :description => script['s'], :script_version => script['rv'],
            :author => script['ra'], :author_email => script['re'],
            :repo_owner => 'vim-scripts'
          }
        end

      end
    end
  end
end
