require 'rails_helper'

RSpec.describe "contents/edit", :type => :view do
  before(:each) do
    @content = assign(:content, Content.create!())
  end

  it "renders the edit content form" do
    render

    assert_select "form[action=?][method=?]", content_path(@content), "post" do
    end
  end
end
