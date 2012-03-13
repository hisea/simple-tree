require "simple_tree/version"
require "simple_tree/railtie" if defined? Rails

module SimpleTree
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def acts_as_simple_tree(options = {})
      configuration = { :foreign_key => "parent_id", :order => nil, :counter_cache => nil }
      configuration.update(options) if options.is_a?(Hash)

      belongs_to :parent, :class_name => name, :foreign_key => configuration[:foreign_key], :counter_cache => configuration[:counter_cache]
      has_many :children, :class_name => name, :foreign_key => configuration[:foreign_key], :order => configuration[:order], :dependent => :destroy

      self.send(:include, SimpleTree::InstanceMethods)
    end
  end
  module InstanceMethods

    # Returns list of ancestors, starting from parent until root.
    #
    #   subchild1.ancestors # => [child1, root]
    def ancestors
      node, nodes = self, []
      nodes << node = node.parent while node.parent
      nodes
    end

    # Returns the root node of the tree.
    def root
      node = self
      node = node.parent while node.parent
      node
    end

    # Returns all siblings of the current node.
    #
    #   subchild1.siblings # => [subchild2]
    def siblings
      self_and_siblings - [self]
    end

    # Returns all siblings and a reference to the current node.
    #
    #   subchild1.self_and_siblings # => [subchild1, subchild2]
    def self_and_siblings
      parent ? parent.children : self.class.roots
    end

  end
end
