class Api::CrumbsController < ApplicationController
  # before_filter :authenticate_user
  before_filter :get_and_authorize_track

  def create
    @crumb = @track.crumbs.new(crumb_params)
    if @crumb && @crumb.save
      render json: @crumb
    else
      render nothing: true, status: 401
    end
  end

  def update
    get_crumb
    if @crumb.update_attributes(crumb_params)
      render json: @crumb
    else
      render nothing: true, status: 401
    end
  end

  def destroy
    get_crumb
    if @crumb && @crumb.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 401
    end
  end

  private

  def crumb_params
    params.require(:crumb).permit(:record_date, :measurement) 
  end

  def get_and_authorize_track
    @track = Track.find_by(id: params[:track_id])
    unless @track # && @track.user == current_user
      render nothing: true, status: 401
    end
  end

  def get_crumb
    @crumb = Crumb.find_by(id: params[:id])
    # unless @crumb && @crumb.track == @track
    #   render nothing: true, status: 401
    # end
  end
end