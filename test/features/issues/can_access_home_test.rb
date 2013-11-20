require "test_helper"

feature 'index page' do
  scenario "sanity" do
    visit '/issues'
    assert_content page, "hello world"
    refute_content page, "Goobye All!"
  end
end
