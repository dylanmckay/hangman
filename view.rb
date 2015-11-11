
class HangmanView
  def prompt_letter
    loop do
      print("Enter a letter: ")
      letter = gets.chomp

      if letter.length == 1
        return letter
      else
        puts("Please enter a single character")
      end
    end
  end

  def show_guess_count(count)
    puts "You have #{count} guesses"
  end

  def show_win_message(word)
    puts("You won! The word was '#{word}'")
  end

  def show_lose_message(word)
    puts("You ran out of turns :( The word was '#{word}'")
  end

  def show_word_status(chars)
    puts("The word is '#{current_word_status_str(chars)}'")
  end

  def show_already_guessed_message(letter)
    puts("You have already correctly guessed '#{letter}'")
  end

  def current_word_status_str(chars)
    chars.map { |c| c == nil ? '_' : c }.join
  end
end

