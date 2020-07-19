require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    csv_loading
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def change_status(recipe)
    recipe.done!
    update_csv
  end

  def update_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.status, recipe.difficulty]
      end
    end
  end

  def csv_loading
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3] == "true", row[4])
    end
  end
end
