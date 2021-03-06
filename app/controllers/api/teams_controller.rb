# frozen_string_literal: true

class Api::TeamsController < ApiController
  before_action :set_team, only: [:show, :update, :destroy]

  def index
    @teams = Team.all
  end

  def show; end

  def create
    @team = Team.new(permitted_params)

    respond_to do |format|
      if @team.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(permitted_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy!
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def permitted_params
    params.fetch(:team, {}).permit(:host, :title, :status)
  end
end
