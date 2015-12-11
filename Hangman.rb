#Hangman
#Select dictionary file and create an array of words appropriate for selection
Dictionary = File.open ("5desk.txt")
require 'yaml'
require 'psych'
require 'rubygems'

 module Hangman

	class Game 
		attr_accessor :board, :letters, :correct, :incorrect, :chances, :name
		def initialize (playernew)
             @playernew= Player.new(self)
			       findword
             @board= @letters
             @name= @playernew.name
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
             print "\nincorrect letters: #{@incorrect}\n#{@name} has #{@chances} chances left :(\n"
             
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
          
          @name= @playernew.name

      print "load game? y/n"
      lg= gets.chomp.downcase
      if lg == "y"
        load
        @letters=@letters
        @correct=@correct
        @c_disp=@c_disp
      elsif lg != "y"
        nil
      end
      @board= @letters      
			chances.times do |x|
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

            print "you lost a chance...you're goin down!\n"
            
			  end 
			  correct_match
			  reveal
			  @chances -= 1
			  save
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
        
        def save
           hash = {
            name: @name,
            chances: @chances,
            incorrect: @incorrect,
            correct: @correct,
            letters: @letters,
            c_disp: @c_disp
           }
           if File.exist?('save.yml')
              File.open('save.yml', 'w') do |file|
                file.write(Psych.dump(hash))
              end
            else
              file =File.new('save.yml', 'w') 
              file.write(Psych.dump(hash))

           end
        end
        def load
              saves= Psych.load_file('save.yml')
             
              @name = saves[:name]
              @chances =  saves[:chances]
              @incorrect= saves[:incorrect]
              @correct= saves[:correct]
              @letters= saves[:letters]
              @c_disp= saves[:c_disp]
              
            
         end

        
	end
	class Player
		attr_accessor :name
		def initialize (name)
            print "What is your name?"
             @name = gets.chomp
             
        end
        

	end
   
end

include Hangman

Game.new(Player).play














#Set up game structure

       
     