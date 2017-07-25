require 'rails_helper'

RSpec.describe "reports/new", type: :view do
  before(:each) do
    assign(:report, Report.new(
      :user_id => 1,
      :semeseter_id => 1,
      :company_id => 1,
      :title => "MyString",
      :internship_report => "MyString"
    ))
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do

      assert_select "input#report_user_id[name=?]", "report[user_id]"

      assert_select "input#report_semeseter_id[name=?]", "report[semeseter_id]"

      assert_select "input#report_company_id[name=?]", "report[company_id]"

      assert_select "input#report_title[name=?]", "report[title]"

      assert_select "input#report_internship_report[name=?]", "report[internship_report]"
    end
  end
end
