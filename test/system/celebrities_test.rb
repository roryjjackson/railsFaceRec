require "application_system_test_case"

class CelebritiesTest < ApplicationSystemTestCase
  setup do
    @celebrity = celebrities(:one)
  end

  test "visiting the index" do
    visit celebrities_url
    assert_selector "h1", text: "Celebrities"
  end

  test "should create celebrity" do
    visit celebrities_url
    click_on "New celebrity"

    fill_in "Name", with: @celebrity.name
    fill_in "Photo url", with: @celebrity.photo_url
    fill_in "User", with: @celebrity.user_id
    click_on "Create Celebrity"

    assert_text "Celebrity was successfully created"
    click_on "Back"
  end

  test "should update Celebrity" do
    visit celebrity_url(@celebrity)
    click_on "Edit this celebrity", match: :first

    fill_in "Name", with: @celebrity.name
    fill_in "Photo url", with: @celebrity.photo_url
    fill_in "User", with: @celebrity.user_id
    click_on "Update Celebrity"

    assert_text "Celebrity was successfully updated"
    click_on "Back"
  end

  test "should destroy Celebrity" do
    visit celebrity_url(@celebrity)
    click_on "Destroy this celebrity", match: :first

    assert_text "Celebrity was successfully destroyed"
  end
end
