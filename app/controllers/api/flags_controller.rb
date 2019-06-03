module Api
  class FlagsController < ApiController
    before_action :set_flag, only: [:show, :edit, :update, :destroy]

    def index
      @flags = Flag.all
    end

    def show
    end

    def new
      @flag = Flag.new
    end

    def edit
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

    def update
      respond_to do |format|
        if @flag.update(flag_params)
          format.json { render :show, status: :ok }
        else
          format.json { render json: @flag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @flag.destroy
      respond_to do |format|
        format.json { head :no_content }
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
