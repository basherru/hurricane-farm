module Api
  class FlagsController < ApiController
    before_action :set_flag, only: [:show]

    def index
      @flags = Flag.all
    end

    def create
      @flag = Flag.new(flag_params)

      respond_to do |format|
        if @flag.save
          format.json { render :show, status: :created }
        else
          format.json { render json: @flag.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_flag
      @flag = Flag.find(params[:id])
    end

    def flag_params
      params.fetch(:flag, {}).permit(:content)
    end
  end
end
