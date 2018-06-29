require 'json'

class NodeError < StandardError
  def initialize(msg="Invalid JavaScript generated!")
    super
  end
end

def node_exec code, env={}
  results = nil
  input = "console.log((#{code}).call(null, #{env.to_json}))"

  # 2>&1 apparently CROSSES STREAMS so that STDERR goes to STDOUT as well
  # TODO: Look into that more (unix)
  # https://www.ruby-forum.com/topic/94084
  # http://lua-users.org/lists/lua-l/2010-09/msg00955.html
  IO.popen('node 2>&1', "w+") do |process|
    results = begin
                process.write(input)
                process.close_write
                process.read.chomp
              rescue
                raise NodeError
              end
  end

  [results, $?]
end
