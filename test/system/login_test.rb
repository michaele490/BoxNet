require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test "can login as a boxer" do
    boxer = Boxer.create!(first_name: "John", last_name: "Doe", username: "johndoe",
    email: "boxer@example.com", password: "password123")
    visit root_path
    find('button', text: "Sign In").hover
    click_on "Boxer"
    assert_current_path new_boxer_session_path
    
    fill_in "Email", with: "boxer@example.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10

    assert_text "John Doe"
    assert_current_path root_path
    take_screenshot
  end

  test "can login as a coach" do
    coach = Coach.create!(first_name: "Jane", last_name: "Doe", username: "janedoe",
    email: "coach@example.com", password: "password123")
    visit root_path
    find('button', text: "Sign In").hover
    click_on "Coach"
    assert_current_path new_coach_session_path

    fill_in "Email", with: "coach@example.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10

    assert_text "Jane Doe"
    assert_current_path root_path
    take_screenshot
  end

  test "can login as an editor" do
    editor = Editor.create!(first_name: "John", last_name: "Bloggs", username: "johnbloggs",
    email: "editor@example.com", password: "password123")
    visit root_path
    find('button', text: "Sign In").hover
    click_on "Editor"
    assert_current_path new_editor_session_path

    fill_in "Email", with: "editor@example.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
    sleep 10

    assert_text "John Bloggs"
    assert_current_path root_path
    take_screenshot
  end
end

