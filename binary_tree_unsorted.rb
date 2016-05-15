class Node
	attr_reader :value
	attr_accessor :parent, :left, :right

	def initialize(value, parent = nil)
		parent_value = parent ? parent.value : "-"
		# puts "Creating new node val #{value} parent #{parent_value}"
		@value = value
		@parent = parent
		@left = nil
		@right = nil
	end
end

def add_to_tree(number, root)
	if number <= root.value
		if root.left
			add_to_tree(number, root.left)
		else
			root.left = Node.new(number, root)
		end
	else
		if root.right
			add_to_tree(number, root.right)
		else
			root.right = Node.new(number, root)
		end
	end
end

def build_tree(data)
	root = Node.new(data.shift, nil)
	data.each {|d| add_to_tree(d, root)}
	root
end

def breadth_first_search(root, search_value)
	# check all the nodes linked to from the starting point, adding them
	# to the queue. When current node is finished, remove from queue
	# and repeat the process for the next element in the queue
	queue = [root]
	result = nil
	until queue.empty?
		#puts "Checking #{queue[0].value}"
		if queue[0].value == search_value
			result = queue[0]
			break
		end
		if queue[0].left
			#puts "Adding #{queue[0].value}'s left to queue"
			queue << queue[0].left
		end
		if queue[0].right
			#puts "Adding #{queue[0].value}'s right to queue"
			queue << queue[0].right
		end
		queue.shift
	end
	if result
		result
	else
		nil
	end
end


def find(x)
	test_tree = build_tree([4,7,2,5,9,8,0,1])
	if !breadth_first_search(test_tree, x).nil?
		puts "#{x} found!"
	else
		puts "#{x} not found!"
	end
end


find(5)
find(3)