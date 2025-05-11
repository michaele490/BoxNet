require "test_helper"

class CoachTest < ActiveSupport::TestCase
  def setup
    @coach = Coach.new(
      email: "coach@example.com",
      password: "password123",
      first_name: "Alice",
      last_name: "Smith",
      username: "alicesmith"
    )
  end

  test "should be valid" do
    assert @coach.valid?
  end

  test "first_name should be present" do
    @coach.first_name = nil
    assert_not @coach.valid?
  end

  test "last_name should be present" do
    @coach.last_name = nil
    assert_not @coach.valid?
  end

  test "username should be present" do
    @coach.username = nil
    assert_not @coach.valid?
  end

  test "username should be unique" do
    duplicate_coach = @coach.dup
    @coach.save
    duplicate_coach.email = "another@example.com"
    assert_not duplicate_coach.valid?
  end

  test "full_name should return first and last name" do
    assert_equal "Alice Smith", @coach.full_name
  end
end
