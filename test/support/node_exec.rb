class NodeError < StandardError
  def initialize(msg="Invalid JavaScript generated!")
    super
  end
end

def node_exec code
  results = nil

  IO.popen('node', "w+") do |process|
    results = begin
                process.write("console.log((#{code}).call())")
                process.close_write
                process.read.chomp
              rescue
                raise NodeError
              end
  end

  results
end
