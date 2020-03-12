# frozen_string_literal: true

class FlagsController < UiController
  before_action :set_flag, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: FlagDatatable.new(params) }
    end
  end

  def show; end

  def new
    @flag = Flag.new
  end

  def edit; end

  def create
    @flag = Flag.new(permitted_params)

    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: "Flag was successfully created." }
        format.json { render :show, status: :created, location: @flag }
      else
        format.html { render :new }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @flag.update(permitted_params)
        format.html { redirect_to @flag, notice: "Flag was successfully updated." }
        format.json { render :show, status: :ok, location: @flag }
      else
        format.html { render :edit }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @flag.destroy!
    respond_to do |format|
      format.html { redirect_to flags_url, notice: "Flag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_flag
    @flag = Flag.find(params[:id])
  end

  def permitted_params
    params.fetch(:flag, {})
  end
end
