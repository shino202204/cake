class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      flash[:notice] = "Genre was successfully created."
      redirect_to admin_genres_index_path
    else
      # flash[:notice] = "NG"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "Genre was successfully updated."
      redirect_to admin_genres_index_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
