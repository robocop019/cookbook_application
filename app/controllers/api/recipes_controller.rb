class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    search_term = params[:search]
    @recipes = @recipes.where('title iLIKE ? OR ingredients iLIKE ?', "%#{search_term}%", "%#{search_term}%") if search_term

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

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title = params[:title] || @recipe.title
    @recipe.chef = params[:chef] || @recipe.chef
    @recipe.prep_time = params[:prep_time] || @recipe.prep_time
    @recipe.ingredients = params[:ingredients] || @recipe.ingredients
    @recipe.directions = params[:directions] || @recipe.directions
    @recipe.image_url = params[:image_url] || @recipe.image_url

    @recipe.save

    render 'show.json.jbuilder'
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render json: {message: 'Successfully destroyed recipe.'}
  end
end
