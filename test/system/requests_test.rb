require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  test "coach can request to add a boxer" do
    # Note: This test is failing at point where test
    # tries to navigate to assign_boxers_path by clicking
    # on the "Add New Boxers" button

    # Create a boxer
    boxer = Boxer.create!(first_name: "Anthony", last_name: "Joshua", username: "anthonyjoshua",
    email: "anthonyjoshua@gmail.com", password: "password123")

    # Create a coach
    coach = Coach.create!(first_name: "John", last_name: "Doe", username: "johndoe",
    email: "johndoe@gmail.com", password: "password123")

    # Login as a coach
    visit new_coach_session_path
    fill_in "Email", with: "johndoe@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10

    visit assign_boxers_path
    sleep 10
    assert current_path == assign_boxers_path
    assert_text "Anthony Joshua"
    click_on "Send add request"
    sleep 10
    # Check if a BoxerRequest was created
    boxer_request = BoxerRequest.find_by(boxer_id: boxer.id, coach_id: coach.id)
    assert_not_nil boxer_request, "BoxerRequest should exist after sending add request"
    assert_includes ["pending", "Pending"], boxer_request.status.to_s, "BoxerRequest status should be 'pending' or 'Pending'"
    take_screenshot
    assert_text "Pending"
  end


  test "boxer can accept a request" do
    # Create a coach
    coach = Coach.create!(
      first_name: "John",
      last_name: "Doe",
      username: "johndoe2",
      email: "johndoe2@gmail.com",
      password: "password123"
    )

    # Create a boxer
    boxer = Boxer.create!(
      first_name: "Anthony",
      last_name: "Joshua",
      username: "anthonyjoshua2",
      email: "anthonyjoshua2@gmail.com",
      password: "password123"
    )

    # Create a boxer request with above users
    boxer_request = BoxerRequest.create!(
      coach: coach,
      boxer: boxer,
      status: :pending
    )

    # Login as a boxer
    visit new_boxer_session_path
    fill_in "Email", with: "anthonyjoshua2@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10
    assert current_path == root_path
    
    # Accept the request
    find('button', text: "Anthony Joshua").hover
    click_on "Requests"
    sleep 10
    assert current_path == boxer_requests_path
    assert_text "Accept"
    assert_text "Reject"
    click_on "Accept"
    sleep 10
    take_screenshot
    
    # Reload the boxer and assert coach assignment
    boxer.reload
    assert_not_nil boxer.coach, "Boxer should have a coach after accepting the request"
    assert_equal coach.id, boxer.coach.id, "Boxer's coach should be the expected coach"
  end

  test "boxer can reject a request" do
    # Create a coach
    coach = Coach.create!(
      first_name: "John",
      last_name: "Doe",
      username: "johndoe3",
      email: "johndoe3@gmail.com",
      password: "password123"
    )

    # Create a boxer
    boxer = Boxer.create!(
      first_name: "Anthony",
      last_name: "Joshua",
      username: "anthonyjoshua3",
      email: "anthonyjoshua3@gmail.com",
      password: "password123"
    )

    # Create a boxer request (status: :pending)
    boxer_request = BoxerRequest.create!(
      coach: coach,
      boxer: boxer,
      status: :pending
    )

    # Login as a boxer
    visit new_boxer_session_path
    fill_in "Email", with: "anthonyjoshua3@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10
    assert current_path == root_path
    
    find('button', text: "Anthony Joshua").hover
    click_on "Requests"
    sleep 10
    assert current_path == boxer_requests_path
    assert_text "Accept"
    assert_text "Reject"
    click_on "Reject"
    sleep 10
    take_screenshot

    # Reload the boxer_request and assert status is 'rejected'
    boxer_request.reload
    assert_equal "rejected", boxer_request.status, "BoxerRequest status should be 'rejected' after rejection"
  end

end
