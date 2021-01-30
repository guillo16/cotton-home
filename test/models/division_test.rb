require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  setup do
    @division = Division.new(name: "Sabanas")
  end

 test "should be valid if all fields are set" do
   assert @division.valid?
 end

 test "should ve invalid if title is nill" do
  @division.name = nil

  assert_not @division.valid?
 end
end
