class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if (params[:ratings] || params[:sort])
      session[:params] = params
    else
      session[:params] ? redirect_to(session[:params]) : {:action=>"index", :controller=>"movies"}
    end
    @all_ratings =Movie.select(:rating).map(&:rating).uniq
    @checked = params[:ratings] ? params[:ratings].keys : @all_ratings
    @movies = Movie.where(:rating=>@checked).order(params[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def title_header
    @movies = Movie.order(:title)
  end
  
  def release_date_header
    @movies = Movie.order(:release_date)
  end

end
