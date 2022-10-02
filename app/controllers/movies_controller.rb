class MoviesController < ApplicationController

  def show
    logger.info "****Print on show****"
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    logger.info "****Print on index****"
    @all_ratings = ['G','PG','PG-13','R']

    logger.info session
    if params['commit'] == 'Refresh' and params['ratings'] == nil
    session['ratings_to_show'] = @all_ratings
    elsif params['commit'] == 'Refresh' and params['ratings'].keys != nil
      session['ratings_to_show'] = params['ratings'].keys
    elsif session['ratings_to_show'] == nil
      session['ratings_to_show'] = @all_ratings
    end
    
    @ratings_to_show = session['ratings_to_show']

    
    if params['sorting'] == 'title'
      session['sorting'] = 'title'
    elsif params['sorting'] == 'date'
      session['sorting'] = 'date'
    elsif session['sorting'] == nil or session['sorting'] == ''
      session['sorting'] = ''
    end

    @sorting = session['sorting']

    logger.info params

    @movies = Movie.with_ratings(@ratings_to_show, @sorting)
    if params != {"controller"=>"movies", "action"=>"index"}
      redirect_to movies_path
    end
  end

  def new
    logger.info "****Print on new****"
    # default: render 'new' template
  end

  def create
    logger.info "****Print on create****"
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    logger.info "****Print on edit****"
    @movie = Movie.find params[:id]
  end

  def update
    logger.info "****Print on update****"
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    logger.info "****Print on destroy****"
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    logger.info "****Print on movie_params****"
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
