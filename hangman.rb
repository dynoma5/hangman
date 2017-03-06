require 'yaml'
class Computer
attr_accessor :chosen_word, :bank
def initialize
	@chosen_word = ""
	@bank
end

def load_word_bank(text = "5desk.txt")
	bank = []
	words = IO.readlines(text)

	words.map do |word|
		numbers = word.length - 2
		bank.push(word[0..numbers])
	end	

	bank = bank.select {|word| word.length <=12 && word.length>=5}
	@bank = bank
end

def choose_word
	total_words = @bank.length
	@chosen_word = @bank[rand(total_words)]
	return @chosen_word
end

end

class Player
attr_accessor :input

def initialize
	@input = []
end

def get_input(input)
	@input.push(input)
end

end

class Board
attr_accessor :board

def initialize 
	@board 
end

def draw_board(word)
	total = word.length
	@board = Array.new(total, "_")
	print "\n\t #{@board}\n"
	return @board
end
	
def check_board(word, letter)
	check = false
	for i in 0..(word.length-1)
		if word[i].downcase == letter.downcase
			@board[i] = word[i]
			check = true
		end
	end
	return check
end

def show_board(counter)
	puts "\n#{counter} more tries left:"
	print "\n\t #{@board}\n"
end

end

def introduction
	puts "Let's play some Hangman! Guess the hidden word!"
end	

def start 
	introduction
	counter = 9
	gameOver = false
	player = Player.new
	generator = Computer.new
	generator.load_word_bank
	generator.choose_word
	board = Board.new
	word = generator.chosen_word
	
	
	board.draw_board(word)
	
	while(counter !=0 or gameOver != true)
		if counter > 0
			puts "\nPlease input a letter."
			input = gets.chomp
			player.get_input(input)
			check = board.check_board(word,input)
			
			
			if check == false
				counter = counter - 1
			else
				puts "\nYou've guessed a letter correctly!\n"
			end	
			
			board.show_board(counter)
			puts "\nLetters guessed: #{player.input}\n"
			
			if board.board.join.downcase == word.downcase
				puts "\nYou win! The word is #{word}"
				gameOver = true
				break
			end
			
		else
			puts "\nGame Over! You lost!\n The word is #{word}"
			break
		end
	end	
end

start
loop do
puts "Do you want to play again? \n"
response = gets.chomp
if response == "yes"
start
else
break
end
end





