module Codebreaker
  class Game
    INVALID_GUESS_MESSAGE    = 'You must guess exactly four numbers.'
    CODEBREAKER_WINS_MESSAGE = 'You won!!!'

    def initialize(output)
      @output = output
    end

    def start(secret)
      @secret = secret
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
    end

    def guess(guess)
      if valid_guess?(guess)
	marker = Marker.new(@secret, guess)
        @output.puts '+'*marker.exact_match_count +
	             '-'*marker.number_match_count
	@output.puts CODEBREAKER_WINS_MESSAGE if perfect_guess?(guess)
      else
        @output.puts INVALID_GUESS_MESSAGE
      end
    end

    def valid_guess?(guess)
      guess_char_count = guess.split('').count

      guess_char_count == 4 &&
      /\d{4}/.match(guess)
    end

    def perfect_guess?(guess)
      guess == @secret
    end
  end
end
