class RecipesController < ApplicationController
  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(:distinct => true).includes(:meal_options, :bookmarks, :ingredients, :fans).page(params[:page]).per(10)

    render("recipes/index.html.erb")
  end

  def show
    @bookmark = Bookmark.new
    @meal_option = MealOption.new
    @recipe = Recipe.find(params[:id])

    render("recipes/show.html.erb")
  end

  def new
    @recipe = Recipe.new

    render("recipes/new.html.erb")
  end

  def create
    @recipe = Recipe.new

    @recipe.recipe_name = params[:recipe_name]
    @recipe.ingredient_list = params[:ingredient_list]
    @recipe.instructions = params[:instructions]
    @recipe.recipe_type = params[:recipe_type]

    save_status = @recipe.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/recipes/new", "/create_recipe"
        redirect_to("/recipes")
      else
        redirect_back(:fallback_location => "/", :notice => "Recipe created successfully.")
      end
    else
      render("recipes/new.html.erb")
    end
    
    @new_ingredients=@recipe.ingredient_list.split(",")
    @new_ingredients.each do |food|
      if Ingredient.find_by(:ingredient_name => food) == nil
        i = Ingredient.new
        i.ingredient_name = food
        i.save
      end
      z = MealOption.new
      z.ingredient_id = Ingredient.find_by(:ingredient_name => food).id
      z.recipe_id = @recipe.id
      z.save
    end
    
  end

  def edit
    @recipe = Recipe.find(params[:id])

    render("recipes/edit.html.erb")
  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.recipe_name = params[:recipe_name]
    @recipe.ingredient_list = params[:ingredient_list]
    @recipe.instructions = params[:instructions]
    @recipe.recipe_type = params[:recipe_type]

    save_status = @recipe.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/recipes/#{@recipe.id}/edit", "/update_recipe"
        redirect_to("/recipes/#{@recipe.id}", :notice => "Recipe updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Recipe updated successfully.")
      end
    else
      render("recipes/edit.html.erb")
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    @recipe.destroy

    if URI(request.referer).path == "/recipes/#{@recipe.id}"
      redirect_to("/", :notice => "Recipe deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Recipe deleted.")
    end
  end
end
