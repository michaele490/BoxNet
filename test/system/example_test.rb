require "application_system_test_case"

class ExampleTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    visit root_path
    assert_text "Sign Up"
  end
end
