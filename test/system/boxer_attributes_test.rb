require "application_system_test_case"

class BoxerAttributesTest < ApplicationSystemTestCase
    test "Boxer attributes are displayed in boxer profile" do
        # Create boxer
        boxer = Boxer.create!(first_name: "Naoya", last_name: "Inoue",
        username: "naoya.inoue", email: "naoya.inoue@gmail.com", password: "password")

        # Create coach
        coach = Coach.create!(first_name: "Shingo", last_name: "Inoue",
        username: "shingo.inoue", email: "shingo.inoue@gmail.com", password: "password")

        # Assign boxer to coach manually
        boxer.coach = coach
        boxer.save!

        # Log in as coach
        visit new_coach_session_path
        fill_in "Email", with: coach.email
        fill_in "Password", with: coach.password
        click_button "Log in"

        # Update boxer attributes
        visit coach_profile_path(coach)
        click_on "Edit"
        sleep 5
        fill_in "Overall rating", with: 96
        fill_in "Power", with: 97
        fill_in "Speed", with: 95
        fill_in "Stamina", with: 87
        fill_in "Iq", with: 91
        fill_in "Defence", with: 86
        
        click_button "Save"
        sleep 5

        # Check if attributes are updated
        assert_current_path coach_profile_path(coach)
        click_on "Naoya Inoue"
        sleep 5
        take_screenshot

        assert_text "96"
        assert_text "97"
        assert_text "95"
        #assert_text "87"
        assert_text "91"
        assert_text "86"

        
    end
end
