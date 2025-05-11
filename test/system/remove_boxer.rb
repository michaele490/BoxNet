require "application_system_test_case"

class RemoveBoxerTest < ApplicationSystemTestCase
    test "Coach can remove a boxer who is assigned to them" do
        # Create boxer
        boxer = Boxer.create!(first_name: "Gervonta", last_name: "Davis",
        username: "gervonta.davis", email: "gervonta.davis@gmail.com", password: "password")

        # Create coach
        coach = Coach.create!(first_name: "Calvin", last_name: "Ford",
        username: "calvin.ford", email: "calvin.ford@gmail.com", password: "password")

        # Assign boxer to coach manually
        boxer.coach = coach
        boxer.save!

        # Log in as coach
        visit new_coach_session_path
        fill_in "Email", with: coach.email
        fill_in "Password", with: coach.password
        click_button "Log in"

        # Remove boxer from coach
        visit coach_profile_path(coach)
        click_on "Remove"
        sleep 5
        take_screenshot

        # Ensure boxer is removed from coach
        assert_text "No boxers added"
    end
end
