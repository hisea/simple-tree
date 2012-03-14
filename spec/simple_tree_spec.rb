require 'spec_helper'


describe SimpleTree do 
  with_model :Test do
    table do |t|
      t.integer :parent_id
      t.string :name
    end
    model do
      include SimpleTree
      acts_as_simple_tree
    end
  end

  before do
    @root = Test.create :name => 'root'
    @c1 = Test.create :name => 'child1', :parent => @root
    @c2 = Test.create :name => 'child1', :parent => @root
    @gc1a = Test.create :name => 'child1', :parent => @c1
    @gc2a = Test.create :name => 'child1', :parent => @c2
  end
  
  describe "#children" do
    it "should return all children" do
      @root.children.should == [@c1,@c2]
    end
  end

  describe "#ancestors" do
    it "should return all ancestors" do
      @gc1a.ancestors.should == [@c1,@root]
    end
  end
  describe "#root" do
    it "should return root for descendants" do
      @gc1a.root.should == @root
    end
    it "should return itself for root" do
      @root.root.should == @root
    end
  end
end