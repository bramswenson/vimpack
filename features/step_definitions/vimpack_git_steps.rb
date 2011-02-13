def check_vimpack_remote(remote_name, url)
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git config -l ; cd - }
    res.should match(/remote.#{remote_name}.url=#{url}/)
  end
end

Then /^the vimpack git remote "([^"]*)" should be "([^"]*)"$/ do |remote_name, url|
  check_vimpack_remote(remote_name, url)
end

