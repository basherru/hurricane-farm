# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: TeamDatatable.new(params) }
    end
  end

  def show; end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @team = Team.new(permitted_params)

    if @team.save
      sync_exploits
      respond_to do |format|
        format.html { redirect_to teams_path }
      end
    else
      head :unprocessable_entity
    end
  end

  def update
    if @team.update(permitted_params)
      sync_exploits
      respond_to do |format|
        format.html { redirect_to teams_path }
      end
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @team.destroy!
    head :no_content
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def permitted_params
    params
      .fetch(:team, {})
      .permit(:host, :title, :status, exploit_ids: [])
      .yield_self { |params| Utils.with_numeric_status(params) }
  end

  def sync_exploits
    permitted_params.fetch(:exploit_ids, []).map { |id| @team.exploits << Exploit.find(id) }
  end
end
