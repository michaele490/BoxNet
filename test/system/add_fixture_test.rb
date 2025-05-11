require "application_system_test_case"

class AddFixtureTest < ApplicationSystemTestCase
  test "add a fixture" do
    # Create boxer 1
    boxer1 = Boxer.create!(first_name: "Terence", last_name: "Crawford", username: "terencecrawford",
    email: "terencecrawford@gmail.com", password: "password123")

    # Create boxer 2
    boxer2 = Boxer.create!(first_name: "Saul", last_name: "Alvarez", username: "saulalvarez",
    email: "saulalvarez@gmail.com", password: "password123")

    # Create editor
    editor = Editor.create!(first_name: "Michael", last_name: "Egharevba", username: "michael.egharevba",
    email: "michael.egharevba@gmail.com", password: "password123")

    # Login as editor
    visit new_editor_session_path
    fill_in "Email", with: "michael.egharevba@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"

    # Navigate to add fixture page
    find('button', text: "Michael Egharevba").click
    within('.dropdown-content') do
        click_on "Fixtures"
      end
    sleep 10
    assert current_path == manage_fixtures_path
    click_on "Add Upcoming Fight"
    sleep 5 # Give modal time to open

    # Wait for boxer1-input to be enabled
    find("#boxer1-input:not([disabled])", visible: true)
    fill_in "boxe1-input", with: "Terence Crawford"
    find('#boxer1-input').send_keys(:down, :enter)
    sleep 15

    # Wait for boxer2-input to be enabled
    take_screenshot # See the state before waiting for boxer2
    find("#boxer2-input:not([disabled])", visible: true)
    fill_in "boxer2-input", with: "Saul Alvarez"
    find('#boxer2-input').send_keys(:down, :enter)

    # Wait for date field to be enabled
    # find("input[name='fight[fight_date]']:not([disabled])")
    fill_in "Date", with: "12092025"
    select "Super Middle", from: "Weight class"
    select "United States", from: "Country"
    fill_in "City", with: "Las Vegas"
    click_on "Save"
    sleep 15

    # Confirm table row has necessary details on page
    assert_text "September 12, 2025"
    assert_text "Terence Crawford"
    assert_text "Saul Alvarez"
    assert_text "Super Middle"
    assert_text "Las Vegas, United States"
  end

  test "added fixture is displayed on editor fixtures page" do
    # Create boxer 1
    boxer1 = Boxer.create!(first_name: "Terence", last_name: "Crawford", username: "terencecrawford",
    email: "terencecrawford@gmail.com", password: "password123")

    # Create boxer 2
    boxer2 = Boxer.create!(first_name: "Saul", last_name: "Alvarez", username: "saulalvarez",
    email: "saulalvarez@gmail.com", password: "password123")

    # Create editor
    editor = Editor.create!(first_name: "Michael", last_name: "Egharevba", username: "michael.egharevba",
    email: "michael.egharevba@gmail.com", password: "password123")

    # Create fight record for upcoming fight
    fight = Fight.create!(boxer_a: boxer1, boxer_b: boxer2, fight_date: "2025-09-12", country: "United States", city: "Las Vegas", editor: editor, status: "scheduled")

    # Login as editor
    visit new_editor_session_path
    fill_in "Email", with: "michael.egharevba@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"

    # Navigate to fixtures page
    find('button', text: "Michael Egharevba").click
    within('.dropdown-content') do
        click_on "Fixtures"
    end
    sleep 10
    assert current_path == manage_fixtures_path

    # Confirm fixture is displayed
    assert_text "September 12, 2025"
    assert_text "Terence Crawford"
    assert_text "Saul Alvarez"
    #assert_text "Super Middle"
    assert_text "Las Vegas, United States"

    take_screenshot
  end

end