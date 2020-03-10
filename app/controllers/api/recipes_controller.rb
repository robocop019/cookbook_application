class Api::RecipesController < ApplicationController
  def index

    # if current_user

    #   @recipes = current_user.recipes
    @recipes = Recipe.all

    search_term = params[:search]
    @recipes = @recipes.where('title iLIKE ? OR ingredients iLIKE ?', "%#{search_term}%", "%#{search_term}%") if search_term

    render 'index.json.jbuilder'  
  end

  def create
    @recipe = Recipe.new(
                        title: params[:title],
                        user_id: 1, #current_user.id,
                        prep_time: params[:prep_time],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        image_url: params[:image_url]
                        )
    if @recipe.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @recipe.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title = params[:title] || @recipe.title
    # @recipe.user_id = current_user.id || @recipe.user_id
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
