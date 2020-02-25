class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render 'index.json.jbuilder'
  end

  def create
    @recipe = Recipe.new(
                        title: params[:title],
                        chef: params[:chef],
                        prep_time: params[:prep_time],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        image_url: params[:image_url]
                        )
    @recipe.save
    render 'show.json.jbuilder'
  end

  def show
    @recipe = Recipe.find(params[:id])
    render 'show.json.jbuilder'
  end
end
