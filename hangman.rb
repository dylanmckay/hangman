
require_relative "model.rb"
require_relative "view.rb"

GUESS_COUNT = 8


class HangmanController

  def initialize(model, view)
    @model = model
    @view = view
  end

  def play
    @view.show_guess_count(@model.remaining_turns)

    play_turn while @model.in_progress?

    if @model.won?
      @view.show_win_message(@model.word)
    else
      @view.show_lose_message(@model.word)
    end

  end

  def play_turn
    @view.show_word_status(@model.status_chars)

    letter = @view.prompt_letter

    if @model.already_guessed?(letter)
      @view.show_already_guessed_message(letter)
    else
      process_letter(letter)
    end
  end

  def process_letter(letter)

    success = @model.try_give_letter(letter)
    @model.take_life if !success
  end
end

