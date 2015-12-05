#Hangman
#Select dictionary file and create an array of words appropriate for selection
Dictionary = File.open ("5desk.txt")

 module Hangman

	class Game 
		attr_accessor :board, :letters
		def initialize (playernew)
             @playernew= Player.new(self)
			 findword
             @board= @letters
             
		end
		def display 
			
             lines ="__"
             position = lambda {|x|   x}
             @linepos = @board 
             @disp= Array.new(@board.length)
              
             if @c_disp != nil
             @disp.each_with_index { |c, k| @c_disp.include?(k)  ? (puts @board[k]) :  (puts lines) }
             
             else
           	    puts @disp.join(" #{lines} ")
             end
             print "\nincorrect letters: #{@incorrect}\n #{@chances}\n"
             
		end
		def findword 
			
			  word= File.read(Dictionary).downcase
              @words=[]
              @words_index= []
              word.scan(/\w+/).each {|w|  @words<<w if w.length.between?(5, 12)}
              @letters = @words.sample.split("").to_a
              @alphanum= Hash[('a'..'z').map.with_index.to_a]
              @letters.each {|w| @words_index<< @alphanum[w]}
              @index_length = @words_index.length.to_i
		end
		def play
			@alpha=('a'..'z').to_a
			    @correct=[]
			    @incorrect=[]
			     @chances= 12
            
			12.times do |x|
				display
				
				
				@guessnum=[]
				print "can you guess what word this is before you die?"
				@guess=gets.chomp.downcase.split("").to_a
				@guess.each {|x| @guessnum<< @alphanum[x] }
                
              if @guessnum==@words_index
				   print "#{@playernew.name} lives!!!" 
				   return
				end
			  if @words_index.include?(@guessnum[0]) # ? (@correct << @alpha[@guessnum[0]]) : (@incorrect<< @alpha[@guessnum[0]])}
			   	    @correct << @alpha[@guessnum[0]]
			  else
			   		@incorrect<< @alpha[@guessnum[0]]

			  end 
			  correct_match
			  reveal
			  @chances= @chances-1
			end	
			print "It was #{@letters}...You're ded-tuff...capital D,E,D-TUFF"	
        end
        def correct_match
        	@c_match=[]
        	@correct.each do |y|
                @c_match << @letters.each_index.select {|z| @letters[z] == y} 
            end
        end
        def reveal
        	@c_disp =[]
            @c_match.each do |v|
            	v.each do |index|
                  @c_disp << index
                end

            end
            @l= " "
            @c_disp.each do |d|
                  @l = @letters[d]
            end
            


        end

	end
	class Player
		attr_reader :name
		def initialize (name)
            print "What is your name?"
             @name = gets.chomp

        end
        

	end

end

include Hangman

Game.new(Player).play














#Set up game structure

       
     