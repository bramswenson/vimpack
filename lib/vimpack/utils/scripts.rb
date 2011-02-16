module Vimpack
  module Utils

    module Scripts

      def install_script(script_name, link_to_bundle=true)
        script = ::Vimpack::Api::Models::Script.get(script_name)
        script_not_found(script_name) if script.nil?
        say(" * installing #{script.name}")
        add_submodule(script.repo_url, script.name)
        if link_to_bundle
          create_link(self.script_path.join(script_name), self.bundle_path.join(script_name))
          say("#{script.name} (#{script.script_version}) installed!")
        end
      end

      def uninstall_script(script_name)
        exit_with_error!('script not found!') unless file_exists?(self.script_path.join(script_name))
        say(" * uninstalling #{script_name}")
        remove_submodule(script_name)
        remove_link(self.bundle_path.join(script_name)) if symlink_exists?(self.bundle_path.join(script_name))
        say("#{script_name} uninstalled!")
      end

      private
      def script_not_found(name)
        scripts = ::Vimpack::Api::Models::Script.search(name, ::Vimpack::Api::Models::Script::SCRIPT_TYPES, 1, 1)
        if scripts.any?
          exit_with_error!("Script not found! Did you mean #{scripts.first.name}?")
        else
          exit_with_error!('Script not found!')
        end
      end

    end

  end
end

