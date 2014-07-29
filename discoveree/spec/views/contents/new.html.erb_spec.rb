require 'rails_helper'

RSpec.describe "contents/new", :type => :view do
  before(:each) do
    assign(:content, Content.new())
  end

  it "renders new content form" do
    render

    assert_select "form[action=?][method=?]", contents_path, "post" do
    end
  end
end
