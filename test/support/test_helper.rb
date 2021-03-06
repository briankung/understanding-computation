require 'pry'
require 'minitest/autorun'
require_relative '../../lib/ast_nodes'
require_relative '../../lib/machine'
require_relative 'node_exec'

include ASTNodes

require 'minitest/reporters'
Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(
    color: true
  )
]
