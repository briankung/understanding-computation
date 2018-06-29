require_relative 'support/test_helper'

Dir['**/*_test.rb', base: 'test'].each do |file|
  require_relative file
end
