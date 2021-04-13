class GamesController < ApplicationController
  def new
    @game = Game.new
    render template: 'runs/new'
  end

  def create
  end

  def index
    @game = Game.all
  end

  def show
    redirect_to gameindex_url(params[:id]) #This brings it to /games/:id/runs instead of /games/:id
  end

  def edit
    @run = Run.find(params[:id2])
    @run.errors = nil
    render template: 'runs/edit'
  end
end
