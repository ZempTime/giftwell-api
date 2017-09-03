require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  test "flexible_where should return a relationship if one exists" do
    relationship = Relationship.flexible_where(users(:ellie).id, users(:chris).id)

    assert_equal relationships(:relationship_chris_ellie), relationship.first
  end

  test "flexible_where should work regardless of argument order" do
    relationship1 = Relationship.flexible_where(users(:ellie).id, users(:chris).id)
    relationship2 = Relationship.flexible_where(users(:chris).id, users(:ellie).id)

    assert_equal relationships(:relationship_chris_ellie), relationship1.first
    assert_equal relationships(:relationship_chris_ellie), relationship2.first
  end

  test "flexible_where should accept user records" do
    relationship = Relationship.flexible_where(users(:ellie), users(:chris))

    assert_equal relationships(:relationship_chris_ellie), relationship.first
  end

  test "flexible_where should return an empty array just like where if nothing exists" do
    relationship = Relationship.flexible_where(users(:will), users(:joe))

    refute relationship.any?
  end
end
