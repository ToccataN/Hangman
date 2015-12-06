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
             d=[]
             if @c_disp != nil
               @disp.each_with_index { |c, k| @c_disp.include?(k)  ? (d<<@board[k]) :  (d<<lines) }
                d.each {|x| print (" #{x} " )}
             else
           	    puts @disp.each {|c| d << lines }
           	    d.each {|x| print (" #{x} ")}
             end
             print "\nincorrect letters: #{@incorrect}\n Chances Left: #{@chances}\n"
             
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
				the_nuce
				
				@guessnum=[]
				print "can you guess what word this is ?"
				@guess=gets.chomp.downcase.split("").to_a
				
				@guess.each {|x| @guessnum<< @alphanum[x] }
                
              if @guessnum==@words_index
				   print "#{@playernew.name} lives!!!" 
				   return
				end
			  if @words_index.include?(@guessnum[0]) # ? (@correct << @alpha[@guessnum[0]]) : (@incorrect<< @alpha[@guessnum[0]])}
			   	    @correct << @alpha[@guessnum[0]]
			  elsif
			   		@incorrect<< @alpha[@guessnum[0]]

			  end 
			  correct_match
			  reveal
			  @chances= @chances-1
			end	
			print "It was #{@letters}...You're ded-tuff...capital D,E,D-TUFF \n__\n| o\n|i0i\n|/^/"	
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
        def the_nuce
          if @chances == 12
              puts "\n\n\n__" 
          elsif @chances == 11
          	  puts "\n\n\n|__"
          elsif @chances == 10
          	  puts "\n\n|\n|__"
          elsif @chances == 9
          	  puts "\n|\n|\n|__"
          	elsif @chances == 8 
          		puts "__\n| \n|\n|__"
          	elsif @chances == 7
          		puts "__o\n| \n| \n|__"
          	elsif @chances == 6
          		puts "__o\n| 0\n| \n|__"
          	elsif @chances == 5
          		puts "__o\n| 0\n| ^\n|__"
          	elsif @chances == 4
          		puts "__o\n| 0\n|/^\n|__"
          	elsif @chances == 3
          		puts "__o\n| 0\n|/^/\n|__"
          	elsif @chances == 2
          		puts "__o\n|i0\n|/^/\n|__"
          	elsif @chances == 1
          		puts "__o\n|i0i\n|/^/\n|__   Dont Poop Yourself On The Way Down!!!"
          		

          		
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

       
     