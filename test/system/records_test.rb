require "application_system_test_case"

class RecordsTest < ApplicationSystemTestCase
    test "Records are updated when a result is added" do
        # Create boxer 1
        boxer1 = Boxer.create!(first_name: "Oleksandr", last_name: "Usyk",
        username: "usyk", email: "usyk@gmail.com", password: "password")

        # Create boxer 2
        boxer2 = Boxer.create!(first_name: "Daniel", last_name: "Dubois",
        username: "dubois", email: "dubois@gmail.com", password: "password")

        # Create editor
        editor = Editor.create!(first_name: "Michael", last_name: "Egharevba",
        username: "michael.egharevba", email: "michael.egharevba@gmail.com", password: "password")
        
        # Create result
        result = Fight.create!(boxer_a: boxer1, boxer_b: boxer2, editor: editor,
        fight_date: "2023-08-26", winner_id: boxer1.id, method: "Knockout", weight_class: "heavy", status: "occurred")

        # Log in as editor
        visit boxer_profile_path(boxer1)
        sleep 5
        take_screenshot

        # Run method to update records
        boxer1.boxer_record.update_record_stats!
        boxer2.boxer_record.update_record_stats!

        assert_text "1 Win"
        assert_text "0 Loss"
        assert_text "0 Draws"

        visit boxer_profile_path(boxer2)
        sleep 5
        take_screenshot

        assert_text "0 Win"
        assert_text "1 Loss"
        assert_text "0 Draws"
        
    end

    test "Records are updated when a draw result is added" do
        # Create boxer 1
        boxer1 = Boxer.create!(first_name: "Oleksandr", last_name: "Usyk",
        username: "usyk", email: "usyk@gmail.com", password: "password")

        # Create boxer 2
        boxer2 = Boxer.create!(first_name: "Daniel", last_name: "Dubois",
        username: "dubois", email: "dubois@gmail.com", password: "password")

        # Create editor
        editor = Editor.create!(first_name: "Michael", last_name: "Egharevba",
        username: "michael.egharevba", email: "michael.egharevba@gmail.com", password: "password")
        
        # Create result as a draw (winner_id: nil)
        result = Fight.create!(boxer_a: boxer1, boxer_b: boxer2, editor: editor,
        fight_date: "2023-08-26", winner_id: nil, method: "Knockout", weight_class: "heavy", status: "occurred")

        # Log in as editor
        visit boxer_profile_path(boxer1)
        sleep 5
        take_screenshot

        # Run method to update records
        boxer1.boxer_record.update_record_stats!
        boxer2.boxer_record.update_record_stats!

        assert_text "0 Win"
        assert_text "0 Loss"
        assert_text "1 Draw"

        visit boxer_profile_path(boxer2)
        sleep 5
        take_screenshot

        assert_text "0 Win"
        assert_text "0 Loss"
        assert_text "1 Draw"
    end
end