class Node
	attr_reader :value
	attr_accessor :parent, :left, :right

	def initialize(value, parent = nil)
		parent_value = parent ? parent.value : "-"
		puts "Creating new node val #{value} parent #{parent_value}"
		@value = value
		@parent = parent
	end
end

def build_node(data, parent)
	if data.empty?
		nil
	elsif data.length == 1
		Node.new(data[0], parent)
	else
		node_index = data.length / 2
		new_node = Node.new(data[node_index], parent)
		new_node.left = build_node(data[0..node_index-1], new_node)
		new_node.right = build_node(data[node_index+1..-1], new_node)
		new_node
	end
end

def build_tree(data)
	build_node(data, nil)
end

build_tree([1,2,3,4,5])

# Can't set the children in the initializer because we don't
# yet have a reference to this node to pass them as a parent