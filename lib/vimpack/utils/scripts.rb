module Vimpack
  module Utils

    module Scripts

      def install_script(script_name, link_to_bundle=true)
        script = ::Vimpack::Api::Models::Script.get(script_name)
        die!("script not found: #{script_name}") if script.nil?
        say(" * installing #{script.name}")
        add_submodule(script.repo_url, script.name)
        if link_to_bundle
          create_link(self.script_path.join(script_name), self.bundle_path.join(script_name))
          say("#{script.name} (#{script.script_version}) installed!")
        end
      end

    end

  end
end

