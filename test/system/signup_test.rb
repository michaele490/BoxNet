require "application_system_test_case"

class UserSignUpsTest < ApplicationSystemTestCase
  test "can sign up as a boxer" do

    visit root_path
    click_on "Sign Up"
    within('.signup', text: "Boxer") do
        click_on "Sign Up"
    end
    sleep 10
    assert_current_path new_boxer_registration_path
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Username", with: "johndoe"
    fill_in "Email", with: "boxer@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_on "Sign up"
    sleep 10

    assert_text "John Doe"

    assert_current_path boxer_details_path
    fill_in "Nickname", with: "Anonymous"
    select "Male", from: "Gender"
    select "welter", from: "Weight class"
    fill_in "Height", with: "1.85"
    fill_in "Reach", with: "1.90"
    select "United Kingdom", from: "Nationality"
    take_screenshot
    click_on "Save Details"
    sleep 15

    visit boxer_profile_path(Boxer.last)
    take_screenshot

    boxer = Boxer.find_by(username: "johndoe")
    assert_equal "Anonymous", boxer.nickname
    assert_equal "Male", boxer.gender
    assert_equal "welter", boxer.weight_class
    assert_equal 1.85, boxer.height
    assert_equal 1.90, boxer.reach
    assert_equal "United Kingdom", boxer.nationality
  end

  test "can sign up as a coach" do
    visit root_path
    click_on "Sign Up"
    within('.signup', text: "Coach") do
        click_on "Sign Up"
    end
    sleep 10
    assert_current_path new_coach_registration_path
    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Doe"
    fill_in "Username", with: "janedoe"
    fill_in "Email", with: "coach@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_on "Sign up"
    sleep 10

    assert_text "Jane Doe"

    assert_current_path root_path
  end
end
