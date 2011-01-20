Given /^"([^"]*)" is my home directory$/ do |dir_name|
  set_env "HOME", File.expand_path(File.join(current_dir, dir_name))
end
