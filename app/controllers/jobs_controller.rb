class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  def index
    if params[:search]
      @jobs = Job.search_job(params[:search])
    elsif params[:tag]
      @jobs = Job.tagged_with(params[:tag])
    else
      @jobs = Job.all
    end
    @tags = Job.tag_counts_on(params[:tag])
  end

  def show
    @related_jobs = @job.find_related_tags
    @geojson = build_geojson
  end

  def new
    @user = current_user
    @job = @user.jobs.new
  end

  def edit
  end

  def create
    @user = current_user
    @job = @user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { render :show, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @job.update(job_params)
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title,
                                  :description,
                                  :url,
                                  :job_type,
                                  :location,
                                  :job_author,
                                  :remote_ok,
                                  :apply_url,
                                  :salary_range,
                                  :start_date,
                                  :industry,
                                  :search,
                                  :tag_list,
                                  images: [])
    end


    def build_geojson
      @job_feature = [@job]
      {
        type: "FeatureCollection",
        features: @job_feature.map(&:to_feature)
      }
    end

end
