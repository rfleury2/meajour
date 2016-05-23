class Api::TracksController < ApplicationController
  def index
    if current_user
      @tracks = current_user.tracks
      render json: @tracks
    else
      render json: {}
    end
  end

  def create
    @track = current_user.tracks.new(track_params)
    if @track.save
      render json: @track
    else
      render nothing: true, status: 401
    end
  end

  def update
    get_and_validate_track
    if @track.update_attributes(track_params)
      render json: @track
    else
      render nothing: true, status: 401
    end
  end

  def destroy
    get_and_validate_track
    if @track.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 401
    end
  end

  private

  def get_and_validate_track
    @track = track.find_by(id: params[:id])
    raise ArgumentError unless @track
    raise NotImplementedError unless @track.user == current_user
  end

  def track_params
    params.require(:track).permit(:name)
  end
end