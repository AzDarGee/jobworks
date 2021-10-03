class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy delete_upload ]
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :js, :html, :json

  def index
    @projects = Project.all
    @tags = ActsAsTaggableOn::Tag.most_used(10).order("created_at DESC")
  end

  def show
    @related_projects = @project.find_related_tags
    @geojson = build_geojson
    impressionist(@project)
  end

  def new
    @user = current_user
    @project = @user.projects.build
  end

  def edit
  end

  def create
    @user = current_user
    @project = @user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_upload
    attachments = ActiveStorage::Attachment.where(id: params[:upload_id])
    attachments.map(&:purge)
    redirect_to edit_project_path(@project), notice: 'Image deleted.'
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(
        :title,
        :description,
        :start_date,
        :end_date,
        :search,
        :price,
        :location,
        :tag_list,
        images: []
      )
    end

    def build_geojson
      @project_feature = [@project]
      {
        type: "FeatureCollection",
        features: @project_feature.map(&:to_feature)
      }
    end
end
