
require_relative "../hangman.rb"

describe HangmanController do
  let(:test_word) { "hello" }
  let(:alphabet) { "abcdefghijklmnopqrstuvwxyz".chars }
  let(:non_contained_chars) { alphabet - test_word.chars }

  let(:model) { HangmanModel.new(test_word) }
  let(:view) { instance_double(HangmanView) }
  let(:controller) { HangmanController.new(model, view) }

  describe "#play" do

    it "shows a message when you lose" do
      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_word_status).at_least(:once)

      non_contained_chars.take(8).each do |c|
        expect(view).to receive(:prompt_letter).and_return(c)
      end

      expect(view).to receive(:show_lose_message)

      controller.play
    end

    it "shows a message when you win" do
      test_word.chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return(c)
      end

      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_win_message)
      controller.play
    end
  end

  describe "#play_turn" do

    it "shows the word status and prompts for a letter" do
      expect(view).to receive(:show_word_status)
      expect(view).to receive(:prompt_letter)

      controller.play_turn
    end

    it "decrements the remaining lives when a guess was incorrect" do
      non_contained_chars.take(8).each_with_index do |c,n|
        expect(view).to receive(:show_word_status)

        expect(view).to receive(:prompt_letter).and_return(c)
        expect(model.remaining_turns).to eq (8-n)

        controller.play_turn
      end
    end

    it "doesn't decrement lives when a guess was correct" do
      test_word.chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return(c)

        controller.play_turn
        expect(model.remaining_turns).to eq 8
      end
    end

  end
end
