class GamesController < ApplicationController #all routes edited
  def new
    @game = Game.new
    render template: 'runs/new'
  end

  def create
  end

  def index
    @game = Game.all
  end

  def userindex
    params[:game] #user searched game
    @game = Game.where('lower(name) LIKE ?', "%#{params[:game].downcase}%").first
    if @game != nil
      @gameplayers = @game.users.uniq
    else
      flash[:notice] = "No search results found for '" + params[:game] + "'!"
      redirect_to games_path
    end
  end



  def show
    redirect_to game_runs_path(params[:id]) #This brings it to /games/:id/runs instead of /games/:id
  end

  def edit
    @run = Run.find(params[:id])
    @run.errors = nil
    render template: 'runs/edit'
  end
end
