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
    @c2 = Test.create :name => 'child2', :parent => @root
    @gc1a = Test.create :name => 'child1 > child a', :parent => @c1
    @gc2a = Test.create :name => 'child2 > child a', :parent => @c2
  end
  
  describe "#children" do
    it "should return all children" do
      @root.children.should == [@c1,@c2]
      @c1.children.should == [@gc1a]
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

  describe "#siblings" do
    it "should return siblings for a child" do
      @c1.siblings.should == [@c2]
    end
    it "should return empty array for root" do
      @root.siblings.should == []
    end
  end

  describe '#self_and_siblings' do
    it "should return siblings and self for a child" do
      @c1.self_and_siblings.should == [@c1,@c2]
    end
    it "should return empty array for root" do
      @root.self_and_siblings.should == []
    end
  end 
  describe '#descendants' do
    it "should return all descendants" do
      @root.descendants.should == [@c1,@c2,@gc1a,@gc2a]
    end
  end

  describe '#move_to_child_of' do
    it "should move a branch to it's new parents" do
      @gc2a.move_to_child_of(@root)
      @gc2a.save
      @gc2a.reload
      @root.reload
      @root.children.should == [@c1,@c2,@gc2a]
      @c2.children.should == []
    end
  end
end