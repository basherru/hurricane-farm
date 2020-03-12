# frozen_string_literal: true

class Api::FlagsController < ApiController
  def index
    @flags = Flag.all
  end

  def create
    @flag = Flag.new(permitted_params)

    respond_to do |format|
      if @flag.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def permitted_params
    params.fetch(:flag, {}).permit(:content)
  end
end
