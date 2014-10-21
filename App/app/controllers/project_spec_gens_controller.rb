class ProjectSpecGensController < ApplicationController

  def update
    @spec = Spec.find_by_project_id(params[:id])
    @spec.spec_name = params[:content][:spec_name][:value]
    @spec.spec_content = params[:content][:spec_content][:value]
    @spec.save!
    render text: ""
  end

  def show
    @spec = Spec.find_by_project_id(params[:id])
  end

end
