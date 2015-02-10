class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_students, only: :show
  before_action :production_disable, only: [:create, :update, :destroy]

  helper_method :courses_cache_key

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.page(params[:page]).includes(:teacher)
               .select(:id, :name, :teacher_id, :enrollments_count)

    fresh_when etag: courses_cache_key
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    fresh_when @course
  end

  # GET /courses/new
  def new
    @course = Course.new
    fresh_when [ @course, form_authenticity_token ]
  end

  # GET /courses/1/edit
  def edit
    fresh_when [ @course, form_authenticity_token ]
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_students
      @students = @course.students.page(params[:page])
    end

    def production_disable
      return if RAILS.env.production?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params[:course]
    end

    def courses_cache_key
      "courses/page-#{params[:page] || 1}-#{courses_count}-#{courses_max_updated_at}-" +
        "teachers/#{teachers_count}-#{teachers_max_updated_at}"
    end

    def courses_count
      Rails.cache.fetch('courses-count') { Course.count }
    end

    def courses_max_updated_at
      Rails.cache.fetch('courses-max-updated-at') do
        Course.maximum(:updated_at).try(:utc).try(:to_s, :number)
      end
    end

    def teachers_count
      Rails.cache.fetch('teachers-count') { Teacher.count }
    end

    def teachers_max_updated_at
      Rails.cache.fetch('teachers-max-updated-at') do
        Teacher.maximum(:updated_at).try(:utc).try(:to_s, :number)
      end
    end
end
