require "application_system_test_case"

class AddResultTest < ApplicationSystemTestCase

    test "Added results are displayed in editor results" do
        # Create boxer 1
        boxer1 = Boxer.create!(first_name: "Oleksandr", last_name: "Usyk",
        username: "usyk", email: "usyk@gmail.com", password: "password")

        # Create boxer 2
        boxer2 = Boxer.create!(first_name: "Daniel", last_name: "Dubois",
        username: "dubois", email: "dubois@gmail.com", password: "password")

        # Create editor
        editor = Editor.create!(first_name: "Michael", last_name: "Egharevba",
        username: "michael.egharevba", email: "michael.egharevba@gmail.com", password: "password")

        # Create fight record where status = 'occurred' (result)
        fight = Fight.create!(boxer_a: boxer1, boxer_b: boxer2, status: "occurred", editor: editor,
        country: "United Kingdom", city: "London", fight_date: "2023-08-26", winner_id: boxer1.id, method: "Knockout", weight_class: "heavy")

        # Log in as editor
        visit new_editor_session_path
        fill_in "Email", with: editor.email
        fill_in "Password", with: editor.password
        click_button "Log in"

        # Visit manage results
        find('button', text: "Michael Egharevba").click
        within('.dropdown-content') do
            click_on "Results"
        end
        sleep 10
        assert current_path == manage_results_path
        take_screenshot

        # Assert the necessary results are present
        assert_text "26 Aug 2023"
        assert_text "Knockout"
        assert_text "Oleksandr Usyk"
        assert_text "Daniel Dubois"

        take_screenshot
        
    end
end