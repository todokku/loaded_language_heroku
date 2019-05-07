require 'pry'
class WordsController < ApplicationController

  def index

    @words = Word.all
  end

  def show
    @word = Word.find_by(id: params[:id])
  end

  def new
    @word = Word.new(user_id: current_user.id)
  end

  def create
    user = current_user
    @word = Word.create(word_params)
    if !@word.errors.full_messages.empty?
      flash[:notice] = "That word is already in the database"
      redirect_to words_path
    end
    @word.update(word_params)
    redirect_to user_word_path(user, @word)
  end

  def edit
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @word = user.words.find_by(id: params[:id])
        redirect_to user_words_path(user), alert: "Word not found." if @word.nil?
      end
    else
      @word = Word.find(params[:id])
    end
  end

  def update
    user = current_user
    @word = Word.find_by(id: params[:id])
    if !@word.errors.full_messages.empty?
      flash[:notice] = "That word is already in the database"
      redirect_to words_path
    end
    @word.update(word_params)
    redirect_to user_word_path(user, @word)
  end

  private

  def word_params
    params.require(:word).permit(:entry, :loaded_rating, :user_id)
  end

end
