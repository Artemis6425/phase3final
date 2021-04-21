class RunsController < ApplicationController

  
  def new
    @game = Game.find_by_id(params[:id])
    @allgames = Game.all
    if (@game != nil)
      @run = Run.new
    else
      redirect_to games_path
    end
  end

  def update
    @run = Run.find(params[:id])
    @run.update(hour: run_params['hour'], minute: run_params['minute'], second: run_params['second'])
    @run.save
    redirect_to gameindex_url(@run.game_id)
  end

  def edit
    @run = Run.find_by_id(params[:id2])
    @game = Game.find_by_id(params[:id])
    if (@game != nil)
      if @game.id.to_i != @run.game_id.to_i
        redirect_to games_path #basically so you can't edit invalid runs / runs that don't exist
      else
        if @run.user_id.to_i != session[:user_id]
          redirect_to games_path #redirects if you are not the owner of the run
        end
                #success if neither of the above fail, brings you to EDIT RUN page
      end
    else
      redirect_to games_path
    end
  end

  def create
    @run = Run.new(run_params)
    if @run.valid? == false
      render 'new'
    else
      if !@run.save
        redirect_to gameindex_url(@run.game_id)
      else
        @run.add_zero
        @run.save
        redirect_to gameindex_url(@run.game_id)
      end
    end
  end

  def index
    @game = Game.find_by_id(params[:id])
    if @game == nil
      redirect_to gamelist_url
    end
  end

  def delete
    @run = Run.find_by_id(params[:id2])
    @game = Game.find_by_id(params[:id])
    if (@run != nil)
      if @game.id.to_i != @run.game_id.to_i
        redirect_to games_path #basically so you can't delete runs that don't exist
      else
        if @run.user_id.to_i != session[:user_id]
          redirect_to games_path #redirects if you are not the owner of the run
        end
        Run.find(params[:id2]).destroy
        redirect_to games_path
      end
    else
      redirect_to games_path
    end

    
  end


  private

  def run_params
    params.require(:run).permit(:hour, :second, :minute, :game_id, :user_id)
  end


end
