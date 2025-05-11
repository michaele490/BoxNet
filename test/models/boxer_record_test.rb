require "test_helper"

class BoxerRecordTest < ActiveSupport::TestCase
  def setup
    @boxer = Boxer.create!(
      email: "boxer1@example.com",
      password: "password123",
      first_name: "Boxer",
      last_name: "One",
      username: "boxerone",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
    @record = BoxerRecord.create!(boxer: @boxer)
  end

  test "should be valid" do
    assert @record.valid?
  end

  test "total_fights should return 0 if no fights" do
    assert_equal 0, @record.total_fights
  end

  test "wins, losses, draws should be 0 if no fights" do
    assert_equal 0, @record.wins
    assert_equal 0, @record.losses
    assert_equal 0, @record.draws
  end

  test "knockout_wins cannot exceed wins" do
    @record.wins = 1
    @record.knockout_wins = 2
    assert_not @record.valid?
    assert_includes @record.errors[:knockout_wins], "cannot be greater than total wins"
  end

  test "knockout_losses cannot exceed losses" do
    @record.losses = 1
    @record.knockout_losses = 2
    assert_not @record.valid?
    assert_includes @record.errors[:knockout_losses], "cannot be greater than total losses"
  end

  test "update_record_stats! updates stats based on fights" do
    # Create fights for the boxer
    editor = Editor.create!(
      email: "editor@example.com",
      password: "password123",
      first_name: "Ed",
      last_name: "Itor",
      username: "editoruser"
    )
    opponent = Boxer.create!(
      email: "opponent@example.com",
      password: "password123",
      first_name: "Opp",
      last_name: "Onent",
      username: "opponentuser",
      weight_class: "welter",
      gender: "Male",
      nationality: "Ireland"
    )
    Fight.create!(boxer_a: @boxer, boxer_b: opponent, editor: editor, status: "occurred", winner_id: @boxer.id, method: "knockout")
    Fight.create!(boxer_a: opponent, boxer_b: @boxer, editor: editor, status: "occurred", winner_id: nil, method: nil)
    Fight.create!(boxer_a: opponent, boxer_b: @boxer, editor: editor, status: "occurred", winner_id: opponent.id, method: "knockout")
    @record.update_record_stats!
    assert_equal 1, @record.wins
    assert_equal 1, @record.draws
    assert_equal 1, @record.losses
    assert_equal 1, @record.knockout_wins
    assert_equal 1, @record.knockout_losses
  end
end
