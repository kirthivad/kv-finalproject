class IngredientsController < ApplicationController
  before_action :current_user_must_be_ingredient_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_ingredient_user
    ingredient = Ingredient.find(params[:id])

    unless current_user == ingredient.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Ingredient.ransack(params[:q])
    @ingredients = @q.result(:distinct => true).includes(:meal_options, :user, :recipes).page(params[:page]).per(10)

    render("ingredients/index.html.erb")
  end

  def show
    @meal_option = MealOption.new
    @ingredient = Ingredient.find(params[:id])

    render("ingredients/show.html.erb")
  end

  def new
    @ingredient = Ingredient.new

    render("ingredients/new.html.erb")
  end

  def create
    @ingredient = Ingredient.new

    @ingredient.user_id = params[:user_id]
    @ingredient.food_group = params[:food_group]

    save_status = @ingredient.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/ingredients/new", "/create_ingredient"
        redirect_to("/ingredients")
      else
        redirect_back(:fallback_location => "/", :notice => "Ingredient created successfully.")
      end
    else
      render("ingredients/new.html.erb")
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])

    render("ingredients/edit.html.erb")
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.food_group = params[:food_group]

    save_status = @ingredient.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/ingredients/#{@ingredient.id}/edit", "/update_ingredient"
        redirect_to("/ingredients/#{@ingredient.id}", :notice => "Ingredient updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Ingredient updated successfully.")
      end
    else
      render("ingredients/edit.html.erb")
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])

    @ingredient.destroy

    if URI(request.referer).path == "/ingredients/#{@ingredient.id}"
      redirect_to("/", :notice => "Ingredient deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Ingredient deleted.")
    end
  end
end
