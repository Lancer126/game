require_relative './player'
require_relative './turn'

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @players = [@player1, @player2]
    @questions = ["1+1?", "2+2?", "3+3?", "4+4?"]
    @answers = [2, 4, 6, 8]
    @turn = Turn.new(@players, @questions, @answers)
  end

  def status
    puts "#{@player1.name}: #{@player1.lives}/3 vs #{@player2.name}: #{@player2.lives}/3"
  end

def game_over?
  @players.select{|player| !player.dead?}.count == 1
end

def winner
  @players.find{|player| !player.dead?}
end

def end_game
  puts '------- GAME OVER -------'
  puts "#{winner.name} wins with a score of #{winner.lives}/3"
end


def run
  until (game_over?) do
    @turn.next_round
    puts "-------- Round##{@turn.round} ------------"
    current_player = @turn.get_current_player
    ennemy_player = @turn.get_ennemy_player(current_player)
    index = @turn.get_current_question
    current_question = @questions[index]
    current_answer = @answers[index]
    
    puts "#{current_player.name}: #{current_question}"
    answer = gets.chomp.to_i
    if answer === current_answer
      puts "#{current_player.name}: Amazing!"
    else
      puts "#{current_player.name}: Seriously? No!"
      current_player.lives -= 1
    end

    # current_player.attacks(ennemy_player)
    status
    puts
  end

  end_game

end

end