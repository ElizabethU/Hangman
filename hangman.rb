require 'colorize'

class Hangman

  def initialize(word)
    @secret_word = word
    @so_far = "-" * @secret_word.length
    @num_wrong = 0
    @guessed_list = []
    status
    guess_a_letter
  end

  def current_info
    puts @so_far
    puts "Letters guessed: " + @guessed_list.sort.join(", ")
  end

  def guess_a_letter
    until winning || losing
      puts "What letter would you like to guess?"
      guess = gets.chomp
      if guessed_multiple_letters(guess)
        puts "Please guess #{'one letter'.red} at a time."
      elsif same_guess(guess)
        puts "You aleady guessed that!"
      elsif is_it_a_number(guess)
        puts "That's a number. This is a game with letters."
      else        
        evaluate_guess(guess)
      end
    end
    end_game_message
  end

  def evaluate_guess(guess)
    @guessed_list << guess
    if @secret_word.include?(guess)
      guess_is_right(guess)
      puts "#{'Congratulations'.green} on your correct guess!"
      puts "-----------------"
    else
      guess_is_wrong(guess)
      puts "No, that's #{'wrong'.red}, sorry!"
      puts "-----------------"
    end
  end

  def end_game_message
    if @so_far == @secret_word
      puts "Congratulations! #{'YOU WON!'.green.underline}"
    else
      puts "Oh no! #{'You lost!'.upcase.red.underline}"
      puts "GAME OVER!".red.underline
      puts "The word was #{@secret_word.red}!"
    end
  end

  def guess_is_right(guess)
    @so_far = @secret_word.tr('^' + @guessed_list.join, '-')
    puts status
  end

  def guess_is_wrong(guess)
    @num_wrong += 1
    puts status
  end

  def guessed_multiple_letters(guess)
    guess.length != 1
  end

  def same_guess(guess)
    @guessed_list.include?(guess)
  end

  def winning #Charlie Sheen
    @so_far == @secret_word
  end

  def losing
    @num_wrong == 6
  end

  def is_it_a_number(guess)
    guess.to_i.to_s == guess
  end

  def status
    case @num_wrong
    when 0
      puts "|--------|"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|============"
    when 1
      puts "|--------|"
      puts "|        O"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|============"
    when 2
      puts "|--------|"
      puts "|        O"
      puts "|        |"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|============"
    when 3
      puts "|--------|"
      puts "|        O"
      puts "|       /|"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|============"
    when 4
      puts "|--------|"
      puts "|        O"
      puts "|       /|\\"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "|============"
    when 5
      puts "|--------|"
      puts "|        O"
      puts "|       /|\\"
      puts "|        /"
      puts "|       |"
      puts "|"
      puts "|"
      puts "|============"
    when 6
      puts "|--------|"
      puts "|        O"
      puts "|       /|\\"
      puts "|        /\\"
      puts "|       | |"
      puts "|"
      puts "|"
      puts "|============"
    end
    puts ""
    current_info
  end
end

my_game = Hangman.new("turtle")