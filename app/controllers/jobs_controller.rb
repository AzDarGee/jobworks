class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy delete_upload ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @jobs = Job.search_job(params[:search])
    elsif params[:tag]
      @jobs = Job.tagged_with(params[:tag])
    else
      @jobs = Job.all.limit(10)
    end
    @tags = Job.tag_counts_on(params[:tag])
  end

  def my_jobs
    @user = current_user
    @my_jobs = current_user.jobs
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

    # STRIPE PAYMENTS
    # token = params[:stripeToken]
    # job_type = params[:job_type]
    # job_title = params[:title]
    # card_brand = params[:user][:card_brand]
    # card_exp_month = params[:user][:card_exp_month]
    # card_exp_year = params[:user][:card_exp_year]
    # card_last4 = params[:user][:card_last4]
    #
    # charge = Stripe::Charge.create(
    #   :amount => 0,
    #   :currency => "usd",
    #   :description => job_type,
    #   :statement_descriptor => job_title,
    #   :source => token
    # )
    #
    # current_user.stripe_id = charge.id
    # current_user.card_brand = card_brand
    # current_user.card_expiry_month = card_exp_month
    # current_user.card_expiry_year = card_exp_year
    # current_user.card_last4 = card_last4
    # current_user.save!

    respond_to do |format|
      if @job.save && (@job.user.role == "Employer")
        format.html { render :show, notice: "Your job listing was purchased successfully." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end

    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new


  end

  def update
    respond_to do |format|
      # binding.pry
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

  def delete_upload
    attachments = ActiveStorage::Attachment.where(id: params[:upload_id])
    attachments.map(&:purge)
    redirect_to edit_job_path(@job), notice: 'Image deleted.'
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
