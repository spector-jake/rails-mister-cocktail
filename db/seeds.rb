# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all


url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredient_list = JSON.parse(ingredients_serialized)

ingredients = ingredient_list['drinks']

ingredients.each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

cocktail_array = ['margarita', 'rum', 'whiskey']

cocktail_array.each do |cocktail_name|
  puts cocktail_name
  cocktail_url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{cocktail_name}"
  cocktails_serialized = open(cocktail_url).read
  cocktail_list = JSON.parse(cocktails_serialized)
  cocktails = cocktail_list['drinks']

  cocktails.each do |cocktail|
    new_cocktail = Cocktail.new(name: cocktail['strDrink'])
    new_cocktail.remote_photo_url = cocktail['strDrinkThumb']
    new_cocktail.save
  end
end
