class Api::TailsController < ApplicationController
  def index
    if current_user
      @tails = current_user.tails
      render json: @tails
    else
      render json: {}
    end
  end

  def create
    @tail = current_user.tails.new(tail_params)
    if @tail.save
      render json: @tail
    else
      render nothing: true, status: 401
    end
  end

  def update
    get_and_validate_tail
    if @tail.update_attributes(tail_params)
      render json: @tail
    else
      render nothing: true, status: 401
    end
  end

  def destroy
    get_and_validate_tail
    if @tail.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 401
    end
  end

  private

  def get_and_validate_tail
    @tail = Tail.find_by(id: params[:id])
    raise ArgumentError unless @tail
    raise NotImplementedError unless @tail.user == current_user
  end

  def tail_params
    params.require(:tail).permit(:name)
  end
end