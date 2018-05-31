task default: %w[test]

task :test do
  begin
    ruby "test/test.rb"
    `terminal-notifier -message '✅✅✅✅✅' && say 'finished'`
  rescue
    `terminal-notifier -message '❗️❗️❗️❗️❗️' && say 'something broke'`
  end
end
