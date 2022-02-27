class TutorController < ApplicationController
  def new
  end
  def create
    new_tutor = Tutor.new
    new_tutor.name = params[:name]
    new_tutor.save
    redirect_to '/'
  end
end
