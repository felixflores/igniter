class ProjectsController < ApplicationController
  def index
    @result = Project::Index.run(params.permit)
    binding.pry
  end
end
