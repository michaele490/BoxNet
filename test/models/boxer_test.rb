require "test_helper"

class BoxerTest < ActiveSupport::TestCase
  def setup
    @boxer = Boxer.new(
      email: "test@example.com",
      password: "password123",
      first_name: "John",
      last_name: "Doe",
      username: "johndoe",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
  end

  test "should be valid" do
    assert @boxer.valid?
  end

  test "first_name should be present" do
    @boxer.first_name = nil
    assert_not @boxer.valid?
  end

  test "last_name should be present" do
    @boxer.last_name = nil
    assert_not @boxer.valid?
  end

  test "username should be present" do
    @boxer.username = nil
    assert_not @boxer.valid?
  end

  test "username should be unique" do
    duplicate_boxer = @boxer.dup
    @boxer.save
    assert_not duplicate_boxer.valid?
  end

  test "weight_class should be valid" do
    @boxer.weight_class = "invalid_weight"
    assert_not @boxer.valid?
  end

  test "gender should be valid" do
    @boxer.gender = "Invalid"
    assert_not @boxer.valid?
  end

  test "nationality should be valid" do
    @boxer.nationality = "Invalid Country"
    assert_not @boxer.valid?
  end

  test "full_name should return first and last name" do
    assert_equal "John Doe", @boxer.full_name
  end

  test "country_code should return correct code" do
    assert_equal "ie", @boxer.country_code
  end

  test "country_code should return nil for blank nationality" do
    @boxer.nationality = nil
    assert_nil @boxer.country_code
  end

  test "meters_to_feet_inches should convert correctly" do
    assert_equal "5'10\"", @boxer.meters_to_feet_inches("1.78")
    assert_equal "N/A", @boxer.meters_to_feet_inches(nil)
  end

  test "nationality_with_flag should return formatted string" do
    assert_includes @boxer.nationality_with_flag, "Ireland"
    assert_includes @boxer.nationality_with_flag, "fi fi-ie"
  end

  test "nationality_with_flag should return N/A for blank nationality" do
    @boxer.nationality = nil
    assert_equal "N/A", @boxer.nationality_with_flag
  end

  test "name_with_id should include full name and id" do
    @boxer.save
    assert_includes @boxer.name_with_id, "John Doe"
    assert_includes @boxer.name_with_id, @boxer.id.to_s
  end

  test "should create boxer record after creation" do
    assert_difference 'BoxerRecord.count' do
      @boxer.save
    end
    assert_not_nil @boxer.boxer_record
  end

  test "all_fights should return unique fights" do
    @boxer.save
    other_boxer1 = Boxer.create!(
      email: "other1@example.com",
      password: "password123",
      first_name: "Jane",
      last_name: "Smith",
      username: "janesmith1",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
    other_boxer2 = Boxer.create!(
      email: "other2@example.com",
      password: "password123",
      first_name: "Jake",
      last_name: "Brown",
      username: "jakebrown2",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
    editor = Editor.create!(
      email: "editor@example.com",
      password: "password123",
      first_name: "Ed",
      last_name: "Itor",
      username: "editoruser"
    )

    fight1 = Fight.create!(boxer_a: @boxer, boxer_b: other_boxer1, editor: editor)
    fight2 = Fight.create!(boxer_a: other_boxer2, boxer_b: @boxer, editor: editor)
    
    assert_equal 2, @boxer.all_fights.count
    assert_includes @boxer.all_fights, fight1
    assert_includes @boxer.all_fights, fight2
  end
end
