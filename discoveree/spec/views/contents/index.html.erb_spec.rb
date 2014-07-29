require 'rails_helper'

RSpec.describe "contents/index", :type => :view do
  before(:each) do
    assign(:contents, [
      Content.create!(),
      Content.create!()
    ])
  end

  it "renders a list of contents" do
    render
  end
end
