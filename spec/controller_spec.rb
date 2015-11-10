
require_relative "../hangman.rb"

TEST_WORD = "hello"

describe HangmanController do

  let(:model) { HangmanModel.new(TEST_WORD) }
  let(:view) { instance_double(HangmanView) }
  let(:controller) { HangmanController.new(model, view) }

  describe "#play" do

    it "shows the word status and prompts for a letter" do
      expect(view).to receive(:show_word_status)
      expect(view).to receive(:prompt_letter)

      controller.play_turn
    end

    it "shows a message when you lose" do
      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_word_status).at_least(:once)
      expect(view).to receive(:prompt_letter).at_least(:once)
      expect(view).to receive(:show_lose_message)

      controller.play
    end

    it "shows a message when you win" do
      TEST_WORD.chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return(c)
      end

      expect(view).to receive(:show_guess_count)
      expect(view).to receive(:show_win_message)
      controller.play
    end

    it "decrements the remaining lives when a guess was incorrect" do
      8.times do |n|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return("a\n")
        expect(model.remaining_turns).to eq (8-n)

        controller.play_turn
      end
    end

    it "doesn't decrement lives when a guess was correct" do
      TEST_WORD.chars.uniq.each do |c|
        expect(view).to receive(:show_word_status)
        expect(view).to receive(:prompt_letter).and_return("#{c}")

        controller.play_turn
        expect(model.remaining_turns).to eq 8
      end
    end

  end
end
