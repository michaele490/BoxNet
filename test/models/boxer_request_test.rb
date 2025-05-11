require "test_helper"

class BoxerRequestTest < ActiveSupport::TestCase
  def setup
    @coach = Coach.create!(
      email: "coach1@example.com",
      password: "password123",
      first_name: "Coach",
      last_name: "One",
      username: "coachone"
    )
    @boxer = Boxer.create!(
      email: "boxer1@example.com",
      password: "password123",
      first_name: "Boxer",
      last_name: "One",
      username: "boxerone",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
    @boxer_request = BoxerRequest.new(coach: @coach, boxer: @boxer)
  end

  test "should be valid" do
    assert @boxer_request.valid?
  end

  test "should enforce uniqueness of coach and boxer pair" do
    @boxer_request.save!
    duplicate = BoxerRequest.new(coach: @coach, boxer: @boxer)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:coach_id], "has already sent a request to this boxer"
  end

  test "should not allow request if boxer already has a coach" do
    @boxer.update!(coach: @coach)
    new_coach = Coach.create!(
      email: "coach2@example.com",
      password: "password123",
      first_name: "Coach",
      last_name: "Two",
      username: "coachtwo"
    )
    request = BoxerRequest.new(coach: new_coach, boxer: @boxer)
    assert_not request.valid?
    assert_includes request.errors[:boxer], "is already assigned to a coach"
  end

  test "status enum should work" do
    @boxer_request.status = :pending
    assert_equal "pending", @boxer_request.status
    @boxer_request.status = :accepted
    assert_equal "accepted", @boxer_request.status
    @boxer_request.status = :rejected
    assert_equal "rejected", @boxer_request.status
  end
end
