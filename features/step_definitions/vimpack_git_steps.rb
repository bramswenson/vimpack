def check_vimpack_remote(remote_name, url)
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git config -l ; cd - }
    res.should match(/remote.#{Regexp.escape(remote_name)}.url=#{Regexp.escape(url)}/)
  end
end

def check_vimpack_last_commit_log(message)
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git log -1 ; cd - }
    res.should match(/#{Regexp.escape(message)}/)
  end
end

Then /^the vimpack git remote "([^"]*)" should be "([^"]*)"$/ do |remote_name, url|
  check_vimpack_remote(remote_name, url)
end

Then /^the vimpack git commit logs last message should be "([^"]*)"$/ do |message|
  check_vimpack_last_commit_log(message)
end

