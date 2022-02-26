class HomeController < ApplicationController
  def index
  end

  def mock
    redirect_to '/home/index'
  end
end
