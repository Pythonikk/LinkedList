# frozen_string_literal: true

# Defines a node based data structure.
class LinkedList
  attr_reader :head

  def initialize(head)
    @head = head
  end

  def tail
    current_node = @head
    next_node = current_node.next_node
    until current_node.next_node.nil?
      current_node = next_node
      next_node = next_node.next_node
    end
    current_node
  end

  def append(value)
    new_node = Node.new(value)
    current_node = tail
    current_node.next_node = new_node
  end

  def prepend(value)
    new_node = Node.new(value)
    old_head = @head
    @head = new_node
    @head.next_node = old_head
  end

  def size
    node_count = 0
    current_node = @head
    until current_node.nil?
      current_node = current_node.next_node
      node_count += 1
    end
    node_count
  end

  def at(index)
    current_node = @head
    current_index = 0
    while current_index < index
      current_node = current_node.next_node
      current_index += 1
    end
    current_node
  end

  def pop
    current_node = @head
    next_node = current_node.next_node
    until current_node.next_node.next_node.nil?
      current_node = next_node
      next_node = next_node.next_node
    end
    current_node.next_node = nil
  end

  def find(value)
    current_node = @head
    current_index = 0
    until current_node.nil? ||
          current_node.value == value
      current_node = current_node.next_node
      current_index += 1
    end
    return nil unless current_node

    current_index
  end

  def contains?(value)
    return true unless find(value).nil?

    false
  end

  def insert_at(value, index)
    new_node = Node.new(value)
    node_at_index = at(index)
    node_after_index = at(index + 1)
    new_node.next_node = node_after_index
    node_at_index.next_node = new_node
  end

  def remove_at(index)
    node_before = at(index - 1)
    node_after = at(index + 1)
    node_before.next_node = node_after
  end
end

# format: ( value ) -> ( value ) -> ( value ) -> nil
def to_s
  string = String.new
  current_node = @head
  next_node = current_node.next_node
  until current_node.nil?
    string.concat("( #{current_node.value} ) -> ")
    current_node = next_node
    next_node = next_node.next_node if next_node
  end
  # appends nil as a string
  string.concat(current_node.inspect)
  puts string
end

# Defines a node
class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end
