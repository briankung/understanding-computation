require 'json'
require 'open3'

class NodeError < StandardError
  def initialize(msg="Invalid JavaScript generated!")
    super
  end
end

def node_exec code, env={}
  result, error = nil, nil
  input = "console.log((#{code}).call(null, #{env.to_json}))"

  Open3.popen3('node') do |stdin, stdout, stderr, thread|
    stdin.write(input)
    stdin.close
    result = stdout.read.chomp
    error = stderr.read
  end

  raise NodeError, error unless error.empty?

  result
end
