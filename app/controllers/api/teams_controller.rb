module Api
  class TeamsController < ApiController
    before_action :set_team, only: [:show, :edit, :update, :destroy]

    def index
      @teams = Team.all
    end

    def show
    end

    def new
      @team = Team.new
    end

    def edit
    end

    def create
      @team = Team.new(team_params)

      respond_to do |format|
        if @team.save
          format.html { redirect_to @team, notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: @team }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to @team, notice: 'Team was successfully updated.' }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :edit }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @team.destroy
      respond_to do |format|
        format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.fetch(:team, {})
    end
  end
end
