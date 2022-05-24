class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "Genre was successfully created."
      redirect_to :index
    end
  end

  def edit
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
