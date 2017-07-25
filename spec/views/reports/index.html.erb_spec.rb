require 'rails_helper'

RSpec.describe "reports/index", type: :view do
  before(:each) do
    assign(:reports, [
      Report.create!(
        :user_id => 2,
        :semeseter_id => 3,
        :company_id => 4,
        :title => "Title",
        :internship_report => "Internship Report"
      ),
      Report.create!(
        :user_id => 2,
        :semeseter_id => 3,
        :company_id => 4,
        :title => "Title",
        :internship_report => "Internship Report"
      )
    ])
  end

  it "renders a list of reports" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Internship Report".to_s, :count => 2
  end
end
