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
		if queue[0].left && search_value < queue[0].value
			#puts "Adding #{queue[0].value}'s left to queue"
			queue << queue[0].left
		end
		if queue[0].right && search_value > queue[0].value
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

def depth_first_search(root, search_value)
	# Node goes on stack as it's visited & checked. Then visit, check
	# and add first child of that node, etc. When a node has no
	# unvisited children, pop off stack and visit new top of stack
	stack = [root]
	result = nil
	visited = []
	until stack.empty?
		current = stack.last
		#puts "Checking #{current.value}"
		if !visited.include?(current)
			visited << current
		end
		if current.value == search_value
			result = current
			break
		end
		if current.left && !visited.include?(current.left)
			#puts "Pushing #{current.value}'s left to stack"
			stack.push(current.left)
		elsif current.right && !visited.include?(current.right)
			#puts "Pushing #{current.value}'s right to stack"
			stack.push(current.right)
		else
			stack.pop
		end
	end
	if result
		result
	else
		nil
	end
end

def dfs_rec(node, search_value)
	l = nil
	r = nil
	if node.left
		l = dfs_rec(node.left, search_value)
	end
	return l if l
	if node.right
		r = dfs_rec(node.right, search_value)
	end
	return r if r
	if node.value == search_value
		node
	else
		nil
	end
end

def find_breadth(x)
	test_tree = build_tree([4,7,2,5,9,8,0,1])
	if !breadth_first_search(test_tree, x).nil?
		puts "#{x} found!"
	else
		puts "#{x} not found!"
	end
end

find_breadth(5)
find_breadth(3)
find_breadth(10)

def find_depth(x)
	test_tree = build_tree([4,7,2,5,9,8,0,1])
	if !depth_first_search(test_tree, x).nil?
		puts "#{x} found!"
	else
		puts "#{x} not found!"
	end
end

find_depth(8)
find_depth(6)
find_depth(1)

def find_dfs(x)
	test_tree = build_tree([4,7,2,5,9,8,0,1])
	if !dfs_rec(test_tree, x).nil?
		puts "#{x} found!"
	else
		puts "#{x} not found!"
	end
end

find_dfs(11)
find_dfs(7)
find_dfs(1)
find_dfs(4)
find_dfs(40)