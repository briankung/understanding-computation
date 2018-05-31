task default: %w[test]

task :test do
  begin
    ruby "test/test.rb"
    `terminal-notifier -message '✅' && say 'tests passing'`
  rescue
    `terminal-notifier -message '❗️' && say 'tests failing'`
  end
end
