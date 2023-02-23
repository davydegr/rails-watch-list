class ListsController < ApplicationController

  before_action :current_list, only: [:show, :destroy]

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def current_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
