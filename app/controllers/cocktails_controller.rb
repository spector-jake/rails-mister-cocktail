class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show]
  before_action :new_cocktail, only: [:index, :show]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def new_cocktail
    @new_cocktail = Cocktail.new
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
