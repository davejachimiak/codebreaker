module Codebreaker
  class Game
    
    def initialize(output)
      @output = output
    end

    def start(secret)
      @secret = secret
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
    end

    def guess(guess)
      if guess.split('').count == 4 && /\d{4}/.match(guess) 
	marker = Marker.new(@secret, guess)
        @output.puts '+'*marker.exact_match_count +
	             '-'*marker.number_match_count
      else
        @output.puts 'You must guess exactly four numbers.'
      end
    end
  end
end
