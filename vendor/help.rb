class GamesController < ApplicationController
  def score
    word = params[:word]
    @letters = params[:letters]
    # The word can’t be built out of the original grid
    condition1 = word.size <= @letters.size
    # The word is valid according to the grid, but is not a valid English word
    condition2 = word_valid?(word) && !english_word?(word)
    # The word is valid according to the grid and is an English word
    condition3 = word_valid?(word) && english_word?(word)

    if condition1 && condition2
      @result = "The word is valid according to the grid, but it is not a valid English word."
    elsif condition1 && condition3
      @result = "The word is valid according to the grid and it is an English word."
    else
      @result = "The word can't be built out of the original grid."
    end
  end

  def new
    letters = Array.new(10) { (('A'..'Z').to_a - VOWELS).sample }
    @letters = letters.shuffle!
  end

  private

  def word_can_be_built?(word, letters)
    word_chars = word.upcase.chars
    letters_chars = letters.chars

    word_chars.all? { |char| letters_chars.include?(char) && letters_chars.delete_at(letters_chars.index(char)) }
  end



  require 'json'
require 'open-uri'

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    result = JSON.parse(response)
    result['found']
  end

  def valid_word?(word)
    word_can_be_built?(word, @letters) && english_word?(word)
  end
end

# valid = true
# word_chars.each do |char|
#   if letters_chars.include?(char)
#     letters_chars.delete_at(letters_chars.index(char))
#   else
#     valid = false
#     break
#   end
# end
# valid







<!-- app/views/games/new.html.erb -->
<h1>New Game</h1>

<p>Grid Letters: <%= @letters.join(", ") %></p>

<%= form_tag("/score", method: "post", data: { turbo: false }) do %>
  <%= label_tag :word, "Enter a word:" %>
  <%= text_field_tag :word %>
  <%= submit_tag "Submit" %>
  <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
<% end %>

<% if @result %>
  <h2>Result:</h2>
  <p><%= @result %></p>
<% end %>





Here are the key changes and improvements:
# config/routes.rb
Rails.application.routes.draw do
    get 'new', to: 'games#new'
    post 'score', to: 'games#score'
  end



class GamesController < ApplicationController

    # app/controllers/games_controller.rb
class GamesController < ApplicationController
    def score
      word = params[:word]
      @letters = params[:letters]
      # The word can’t be built out of the original grid
      condition1 = word.size <= @letters.size
      # The word is valid according to the grid, but is not a valid English word
      condition2 = word_valid?(word) && !english_word?(word)
      # The word is valid according to the grid and is an English word
      condition3 = word_valid?(word) && english_word?(word)

      if condition1 && condition2
        @result = "The word is valid according to the grid, but it is not a valid English word."
      elsif condition1 && condition3
        @result = "The word is valid according to the grid and it is an English word."
      else
        @result = "The word can't be built out of the original grid."
      end
    end

    def new
      @letters = Array.new(10) { (('A'..'Z').to_a - VOWELS).sample }
      @letters.shuffle!
    end

    private


  end


 end










rails new rails-longest-word-game --skip-active-storage --skip-action-mailbox
git add .
git commit -m "rails new"
gh repo create --public --source=.
git push origin master

# Step 2: Design the UI and Routes

# Create a GamesController with two actions, new and score:

rails generate controller Games new score

# Open the config/routes.rb file and adjust the routes to match the following:

Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
# Step 3: Generating a new game

In the new action of the GamesController, generate an array of ten random
@letters = rand(1..10)
 letters and store them in the @letters instance variable.
Display the @letters array in the view.
Step 4: Submitting a word

# Add a form below the letters in the view to allow
# the user to submit a word suggestion.
# Set the form's action to "score" and the method to "post".
# Disable the Turbo Links feature for the form by adding data-turbo="false" to the form tag.
# Add a hidden input field with the authenticity token to ensure the request's security.

<%= hidden_field_tag :authenticity_token, form_authenticity_token %>

# Step 5: Handling the form submission

# In the score action of the GamesController, access the submitted word and the original
#  grid letters from the params hash.
# Implement the logic to compute the score based on the scenarios mentioned
#  (valid word, valid according to the grid, etc.).
# Store the score in the session to persist it across HTTP requests.

Step 6: Displaying the results and linking back to a new game

Display the result of the score calculation in the view.
Add a link using link_to to go back to the new page for starting a new game.

Step 7 (Optional): Adding score persistence

Use the Rails session to store, compute, and display a grand total score for the user.
Calculate the score for each game and add it to the grand total.

Step 8: Designing your app

Install Bootstrap by adding the Bootstrap
CSS link tag to the <head> section of your application layout (app/views/layouts/application.html.erb).
Customize the design
 of your application by writing your own CSS rules in the app/assets/stylesheets/application.css file.
