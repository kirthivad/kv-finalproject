class MealOptionsController < ApplicationController
  def index
    @q = MealOption.ransack(params[:q])
    @meal_options = @q.result(:distinct => true).includes(:ingredient, :recipe).page(params[:page]).per(10)

    render("meal_options/index.html.erb")
  end

  def show
    @meal_option = MealOption.find(params[:id])

    render("meal_options/show.html.erb")
  end

  def new
    @meal_option = MealOption.new

    render("meal_options/new.html.erb")
  end

  def create
    @meal_option = MealOption.new

    @meal_option.ingredient_id = params[:ingredient_id]
    @meal_option.recipe_id = params[:recipe_id]

    save_status = @meal_option.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/meal_options/new", "/create_meal_option"
        redirect_to("/meal_options")
      else
        redirect_back(:fallback_location => "/", :notice => "Meal option created successfully.")
      end
    else
      render("meal_options/new.html.erb")
    end
  end

  def edit
    @meal_option = MealOption.find(params[:id])

    render("meal_options/edit.html.erb")
  end

  def update
    @meal_option = MealOption.find(params[:id])

    @meal_option.ingredient_id = params[:ingredient_id]
    @meal_option.recipe_id = params[:recipe_id]

    save_status = @meal_option.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/meal_options/#{@meal_option.id}/edit", "/update_meal_option"
        redirect_to("/meal_options/#{@meal_option.id}", :notice => "Meal option updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Meal option updated successfully.")
      end
    else
      render("meal_options/edit.html.erb")
    end
  end

  def destroy
    @meal_option = MealOption.find(params[:id])

    @meal_option.destroy

    if URI(request.referer).path == "/meal_options/#{@meal_option.id}"
      redirect_to("/", :notice => "Meal option deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Meal option deleted.")
    end
  end
end
