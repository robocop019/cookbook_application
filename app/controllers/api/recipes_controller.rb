class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render 'index.json.jbuilder'
  end

  def show
    @recipe = Recipe.find(params[:id])
    render 'show.json.jbuilder'
  end
end
