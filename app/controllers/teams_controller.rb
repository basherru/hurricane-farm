class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: TeamDatatable.new(params) }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /teams/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      respond_to do |format|
        format.html { redirect_to teams_path }
      end
    else
      head :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      respond_to do |format|
        format.html { redirect_to teams_path }
      end
    else
      head :unprocessable_entity
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      _team_params = params.fetch(:team, {}).permit(:host, :title, :status)
      _team_params[:status] = _team_params[:status] == 'active' ? 1 : 0
      _team_params
    end
end
