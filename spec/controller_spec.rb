
require_relative "../hangman.rb"

describe HangmanController do

#  let(:model) { instance_double(HangmanModel) }
#  let(:view) { instance_double(HangmanView) }
#  let(:controller) { HangmanController.new(model,view) }

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
  end
end
