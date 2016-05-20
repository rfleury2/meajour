class Api::CrumbsController < ApplicationController
  # before_filter :authenticate_user
  before_filter :get_and_authorize_tail

  def create
    @crumb = @tail.crumbs.new(crumbs_params)
    if @crumb.save
      render json: @crumb
    else
      render nothing: true, status: 401
    end
  end

  def update
    get_crumb
    @crumb 
  end

  def destroy
    get_crumb
    if @crumb.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 401
    end
  end

  private

  def crumbs_params
    params.require(:crumb).permit(:record_date, :measurement) 
  end

  def get_and_authorize_tail
    @tail = Tail.find_by(id: params[:tail_id])
    unless @tail # && @tail.user == current_user
      render nothing: true, status: 401
    end
  end

  def get_crumb
    @crumb = Crumb.find_by(id: params[:id])
    unless @crumb && @crumb.tail == @tail
      render nothing: true, status: 401
    end
  end
end