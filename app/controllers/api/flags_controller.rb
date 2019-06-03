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
          format.html { redirect_to @flag, notice: 'Flag was successfully created.' }
          format.json { render :show, status: :created, location: @flag }
        else
          format.html { render :new }
          format.json { render json: @flag.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @flag.update(flag_params)
          format.html { redirect_to @flag, notice: 'Flag was successfully updated.' }
          format.json { render :show, status: :ok, location: @flag }
        else
          format.html { render :edit }
          format.json { render json: @flag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @flag.destroy
      respond_to do |format|
        format.html { redirect_to flags_url, notice: 'Flag was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_flag
      @flag = Flag.find(params[:id])
    end

    def flag_params
      params.fetch(:flag, {})
    end
  end
end
