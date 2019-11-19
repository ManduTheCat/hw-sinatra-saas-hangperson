class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

    # @@chars_stack = []
    attr_accessor :word
    attr_accessor :guesses
    attr_accessor :wrong_guesses

  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses= ''
  end
  
  
  def guess(letter)
    raise ArgumentError, "Guessed letter can't be nil" if letter == nil
    raise ArgumentError, "Guessed letter can't be empty" if letter.empty?
    raise ArgumentError, "Guessed letter must be a letter" if !letter.match(/[a-z]/i)
    
    letter_down = letter.downcase
    if @guesses.include? letter_down or @wrong_guesses.include? letter_down or letter_down.match(/[^a-zA-Z]/)
      valid = false
    else
      if @word.downcase.include? (letter_down)
        @guesses += letter_down
      else
        @wrong_guesses += letter_down
      end
      valid = true
    end
    valid
  end
  
  def word_with_guesses
    interval = ''
    @word.chars do |c|
      if guesses.include?(c)
        interval += c
      else
        interval += "-"
      end
    end
    interval
  end
  
  def check_win_or_lose
    status = :play
    if @wrong_guesses.length < 7 and word_with_guesses == @word
      status = :win
    elsif @wrong_guesses.length >= 7 
      status = :lose
    end
    return status
  end
    

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
