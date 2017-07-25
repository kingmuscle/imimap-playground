class ReportOverviewController < ApplicationController
  respond_to :html, :json
  before_filter :get_programming_languages, :get_orientations, :only => [:edit, :update]
  before_filter :authorize
  before_filter :authorize_internship, :only => [:edit, :update, :destroy]



  # GET /report_overview
  # GET /report_overview.json
  def index
    @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order("internships.created_at DESC")


    #@reports = Report.collect(&:country)


    @companies = @internships.collect(&:company)


    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }


    @names = @internships.collect(&:enrolment_number)


    semesters = params[:semester].collect(&:to_i) if params[:semester]


    @internships = @internships.where(:companies => {:country => params[:country]}) if params[:country].present?

    @internships = @internships.where(:semester_id => semesters) if semesters.present?

    @country_choices = params[:country] if params[:country].present?
    @semester_choices = params[:semester] if params[:semester].present?



    @internships_size = @internships.size

    respond_with(@internships)
  end



  # GET /internships/1
  # GET /internships/1.json
  def show
    @internship = Internship.find(params[:id])
    @comment = UserComment.new
    @answer = Answer.new
    @favorite = Favorite.where(:internship_id => @internship.id, :user_id => current_user.id)[0]
    @company = @internship.company
    @other_internships = @company.internships.reject { |x| x.id == @internship.id }.reject{ |i| i.completed == false }

    @user_comments = @internship.user_comments.order("created_at DESC")

    Gmaps4rails.build_markers(@internship.company) do |company, marker |
      marker.infowindow ("Company")
    end

    respond_with(@internship)
  end



  # GET /internships/1/edit
  def edit
    @internship = Internship.find(params[:id])
    @company = @internship.company
    @rating = @internship.internship_rating
  end

  # PUT /internships/1
  # PUT /internships/1.json
  def update
    @internship = Internship.find(params[:id])
    attributes = params[:internship]
    attributes.delete(:company_id)
    if @internship.update_attributes(attributes)
      @internship.update_attributes(completed: true)
      flash[:notice] = 'Internship was successfully updated.'
      respond_with(@internship)
    else
      @rating = @internship.build_internship_rating
      render :edit, notice: "Please fill in all fields"
    end
  end

  # DELETE /internships/1
  # DELETE /internships/1.json
  def destroy
    @internship = Internship.find(params[:id])
    @internship.destroy

    respond_to do |format|
      format.html { redirect_to internships_url }
      format.json { head :no_content }
    end
  end



  private

  def authorize_internship
    internship = Internship.where(id: params[:id]).first
    if current_user.student && internship && internship.student_id != current_user.student.id
      redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
    elsif internship.nil?
      redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
    end
  end

end
