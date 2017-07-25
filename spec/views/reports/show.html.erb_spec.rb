require 'rails_helper'

RSpec.describe "reports/show", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      :user_id => 2,
      :semeseter_id => 3,
      :company_id => 4,
      :title => "Title",
      :internship_report => "Internship Report"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Internship Report/)
  end
end
