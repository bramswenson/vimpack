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

def check_vimpack_status
  prep_for_fs_check do
    res = %x{ cd test_vimpack/.vimpack ; git status ; cd - }
    res.should match(/#{Regexp.escape('nothing to commit')}/)
  end
end


Then /^the vimpack git remote "([^"]*)" should be "([^"]*)"$/ do |remote_name, url|
  check_vimpack_remote(remote_name, url)
end

Then /^the vimpack git commit logs last message should be "([^"]*)"$/ do |message|
  check_vimpack_last_commit_log(message)
end

Then /^the vimpack git status should be empty$/ do
  check_vimpack_status
end
