class ReportsController < InheritedResources::Base

  private

    def report_params
      params.require(:report).permit(:user_id, :semeseter_id, :start_date, :end_date, :company_id, :title, :internship_report)
    end
end

