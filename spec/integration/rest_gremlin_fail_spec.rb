require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Neography::Rest do
  before(:each) do
    @neo = Neography::Rest.new
  end

  describe "don't break gremlin" do
    it "can handle node and relationship indexes" do
      new_node1 = @neo.create_node
      new_node2 = @neo.create_node
      new_relationship = @neo.create_relationship("friends", new_node1, new_node2)
      key = generate_text(6)
      value = generate_text
      @neo.add_node_to_index("test_index", key, value, new_node1)
      @neo.add_relationship_to_index("test_index2", key, value, new_relationship) 
    end

    it "gremlin works" do
      root_node = @neo.execute_script("g.v(0)")
      root_node.should have_key("self")
      root_node["self"].split('/').last.should == "0"
    end
  end


  describe "break gremlin" do
    it "can can't handle node and relationship indexes with the same name", :break_gremlin => true do
      new_node1 = @neo.create_node
      new_node2 = @neo.create_node
      new_relationship = @neo.create_relationship("friends", new_node1, new_node2)
      key = generate_text(6)
      value = generate_text
      @neo.add_node_to_index("test_index3", key, value, new_node1)
      @neo.add_relationship_to_index("test_index3", key, value, new_relationship) 
    end

    it "gremlin works" do
      root_node = @neo.execute_script("g.v(0)")
      root_node.should have_key("self")
      root_node["self"].split('/').last.should == "0"
    end
  end


end