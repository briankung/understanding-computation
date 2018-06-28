require 'pry'
require 'minitest/autorun'
require_relative '../lib/ast_nodes'

include ASTNodes

require 'minitest/reporters'
Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(
    color: true
  )
]
