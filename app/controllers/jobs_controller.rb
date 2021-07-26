class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  def index
    @jobs = Job.all
  end

  def show
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
      if ((@job.save) && (@job.user.role == "Employer"))
        format.html { redirect_to @job, notice: "Job was successfully created." }
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
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
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
                                  images: [])
    end
end
