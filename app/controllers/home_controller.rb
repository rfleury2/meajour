class HomeController < ApplicationController
  def index
    render json: {in: true}
  end
end