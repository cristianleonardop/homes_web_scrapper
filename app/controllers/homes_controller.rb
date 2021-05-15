class HomesController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]

  # GET /homes or /homes.json
  def index
    @scrap_url = 'https://abilene.craigslist.org/search/hhh?min_bedrooms=3&max_bedrooms=3&max_bathrooms=2&min_bathrooms=2'
    @homes = Home.all

    respond_to do |format|
      format.html
      format.csv { render json: @homes.to_csv, layout: false }
    end
  end

  # GET /homes/1 or /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes or /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: "Home was successfully created." }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1 or /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: "Home was successfully updated." }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1 or /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: "Home was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def spider
    response = Spiders::HomeService.process(params[:query])
    if response[:status] == :completed && response[:error].nil?
      flash.now[:notice] = "Successfully scraped url"
      redirect_to root_path
    else
      flash.now[:alert] = response[:error]
    end
  rescue StandardError => e
    flash.now[:alert] = "Error: #{e}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.require(:home).permit(:title, :address, :monthly_rent, :url)
    end
end
