require "test_helper"

class EditorTest < ActiveSupport::TestCase
  def setup
    @editor = Editor.new(
      email: "editor@example.com",
      password: "password123",
      first_name: "Eve",
      last_name: "Johnson",
      username: "evejohnson"
    )
  end

  test "should be valid" do
    assert @editor.valid?
  end

  test "first_name should be present" do
    @editor.first_name = nil
    assert_not @editor.valid?
  end

  test "last_name should be present" do
    @editor.last_name = nil
    assert_not @editor.valid?
  end

  test "username should be present" do
    @editor.username = nil
    assert_not @editor.valid?
  end

  test "username should be unique" do
    duplicate_editor = @editor.dup
    @editor.save
    duplicate_editor.email = "anothereditor@example.com"
    assert_not duplicate_editor.valid?
  end

  test "full_name should return first and last name" do
    assert_equal "Eve Johnson", @editor.full_name
  end
end 