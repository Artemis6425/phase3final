class RunsController < ApplicationController #all routes edited

  
  def new
    @game = Game.find_by_id(params[:game_id])
    @allgames = Game.all
    if (@game != nil)
      @run = Run.new(game_id: params[:game_id])
    else
      redirect_to games_path
    end
  end

  def update
    @run = Run.find(params[:id])
    @run.update(hour: run_params['hour'], minute: run_params['minute'], second: run_params['second'])
    @run.save
    redirect_to game_runs_path(@run.game_id)
  end

  def edit
    @run = Run.find_by_id(params[:id])
    @game = Game.find_by_id(params[:game_id])
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
    @game = Game.find_by_id(run_params[:game_id])
    if @run.valid? == false
      render 'new'
    else
      @run.add_zero
      if !@run.save
        redirect_to game_runs_path(@run.game_id)
      else
        @run.save
        redirect_to game_runs_path(@run.game_id)
      end
    end
  end

  def index
    @game = Game.find_by_id(params[:game_id])
    @gamesorted = @game.runs.order(:hour).order(:minute).order(:second)
    if @game == nil
      redirect_to games_path
    end
  end

  def destroy
    @run = Run.find_by_id(params[:id])
    @game = Game.find_by_id(params[:game_id])
    if (@run != nil)
      if @game.id.to_i != @run.game_id.to_i
        redirect_to games_path #basically so you can't delete runs that don't exist
      else
        if @run.user_id.to_i != session[:user_id]
          redirect_to games_path #redirects if you are not the owner of the run
        end
        Run.find(params[:id]).destroy
        redirect_to game_runs_path(params[:game_id])
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
