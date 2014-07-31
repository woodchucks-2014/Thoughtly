require 'rails_helper'

RSpec.describe "contents/show", :type => :view do
  before(:each) do
    @content = assign(:content, Content.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
