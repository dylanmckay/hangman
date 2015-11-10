
require_relative "../hangman.rb"

describe HangmanController do

  describe "#play" do

    it "shows the word status and prompts for a letter" do
      model = HangmanModel.new("hello")
      view = instance_double(HangmanView)
      controller = HangmanController.new(model,view)

      expect(view).to receive(:show_word_status)
      expect(view).to receive(:prompt_letter)

      controller.play_turn
    end

    it "shows a message when you lose" do
      model = HangmanModel.new("hello")
      view = instance_double(HangmanView)
      controller = HangmanController.new(model, view)

      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_word_status).at_least(:once)
      expect(view).to receive(:prompt_letter).at_least(:once)
      expect(view).to receive(:show_lose_message)

      controller.play
    end

    it "shows a message when you win" do
      TEST_WORD = "hello"

      model = HangmanModel.new(TEST_WORD)
      view = instance_double(HangmanView)
      controller = HangmanController.new(model, view)

      TEST_WORD.chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return(c)
      end

      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_win_message)
      controller.play
    end

    it "decrements the remaining lives when a guess was incorrect" do
      model = HangmanModel.new("hello")
      view = instance_double(HangmanView)
      controller = HangmanController.new(model, view)

      "hello".chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return("#{c}")

        controller.play_turn
        expect(model.remaining_turns).to eq 8
      end

      8.times do |n|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return("a\n")
        expect(model.remaining_turns).to eq (8-n)

        controller.play_turn
      end
    end
  end
end
