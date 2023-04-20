class CelebritiesController < ApplicationController
  before_action :set_celebrity, only: %i[ show edit update destroy ]

  # GET /celebrities or /celebrities.json
  def index
    @celebrities = policy_scope(Celebrity)
  end

  # GET /celebrities/1 or /celebrities/1.json
  def show
    authorize @celebrity
  end

  # GET /celebrities/new
  def new
    @celebrity = Celebrity.new
    authorize @celebrity
  end

  # GET /celebrities/1/edit
  def edit
    authorize @celebrity
  end

  # POST /celebrities or /celebrities.json
  def create
    @celebrity = Celebrity.new(celebrity_params)
    @celebrity.user = current_user
    authorize @celebrity

    respond_to do |format|
      if @celebrity.save
        format.html { redirect_to celebrity_url(@celebrity), notice: "Celebrity was successfully created." }
        format.json { render :show, status: :created, location: @celebrity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /celebrities/1 or /celebrities/1.json
  def update
    authorize @celebrity

    respond_to do |format|
      if @celebrity.update(celebrity_params)
        format.html { redirect_to celebrity_url(@celebrity), notice: "Celebrity was successfully updated." }
        format.json { render :show, status: :ok, location: @celebrity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /celebrities/1 or /celebrities/1.json
  def destroy
    authorize @celebrity
    @celebrity.destroy

    respond_to do |format|
      format.html { redirect_to celebrities_url, notice: "Celebrity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_celebrity
      @celebrity = Celebrity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def celebrity_params
      params.require(:celebrity).permit(:name, :photo_url)
    end
end
