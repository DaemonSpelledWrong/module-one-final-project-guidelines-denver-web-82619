# frozen_string_literal: true

# class CLI
class Cli
  attr_reader :prompt, :box
  def initialize
    @prompt = TTY::Prompt.new
  end

  def main_menu
    clear
    game_title
    spacing
    player_choice = prompt.select('What would you like to do?', %w[Play Exit])
    spacing
    player_choice == 'Play' ? clear && start : exit
  end

  def start
    spacing
    poke_choice = prompt.select('Which pokemon do you prefer?', Pokemon.all.map(&:name))

    player = Pokemon.all.select do |pokemon|
      pokemon.name = poke_choice
    end
    clear
    location(player)
  end

  def location(player)
    spacing
    clear
    location_choice = prompt.select('Which location would you like to challenge?', %w[Deathly_Volcano Battle_Stadium Pokemon_League Quit])
    if location_choice == 'Quit'
      exit
    else
      battle(player)
    end
  end

  def battle(player)
    enemy = Pokemon.all.sample
    player_health = player[0].health
    enemy_health = enemy.health
    while player_health.positive? && enemy_health.positive?
      enemy_health -= player_turn(player)
      puts "The enemy has #{enemy_health} HP left!"
      if enemy_health.positive?
        player_health -= enemy_turn(enemy)
      end
      puts "You have #{player_health} HP left!"
    end
    if player_health.positive?
      location(player)
    else
      main_menu
    end
  end

  def player_turn(player)
    spacing
    move_choice = prompt.select('Which attack will you use!?', player[0].attacks).downcase
    PokeAtt.damage_value(move_choice)
  end

  def enemy_turn(enemy)
    spacing
    move_choice = enemy.enemy_attack.sample.downcase
    puts "The enemy used #{move_choice}!"
    spacing
    PokeAtt.damage_value(move_choice)
  end

  def spacing
    puts ' '
    puts ' '
    puts ' '
    puts ' '
    puts ' '
  end

  def clear
    system('clear')
  end

  def game_title
    box = TTY::Box.frame(
      width: 150,
      height: 20,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
      padding: 3
    ) do
      '
       _______            __                  ________  __            __          __     __ 
      /       \          /  |                /        |/  |          /  |        /  |   /  |
      $$$$$$$  | ______  $$ |   __   ______  $$$$$$$$/ $$/   ______  $$ |____   _$$ |_  $$ |
      $$ |__$$ |/      \ $$ |  /  | /      \ $$ |__    /  | /      \ $$      \ / $$   | $$ |
      $$    $$//$$$$$$  |$$ |_/$$/ /$$$$$$  |$$    |   $$ |/$$$$$$  |$$$$$$$  |$$$$$$/  $$ |
      $$$$$$$/ $$ |  $$ |$$   $$<  $$    $$ |$$$$$/    $$ |$$ |  $$ |$$ |  $$ |  $$ | __$$/ 
      $$ |     $$ \__$$ |$$$$$$  \ $$$$$$$$/ $$ |      $$ |$$ \__$$ |$$ |  $$ |  $$ |/  |__ 
      $$ |     $$    $$/ $$ | $$  |$$       |$$ |      $$ |$$    $$ |$$ |  $$ |  $$  $$//  |
      $$/       $$$$$$/  $$/   $$/  $$$$$$$/ $$/       $$/  $$$$$$$ |$$/   $$/    $$$$/ $$/ 
                                                           /  \__$$ |                       
                                                           $$    $$/                        
                                                            $$$$$$/                         '
    end
    print box
  end
end
