# -*- coding: utf-8 -*-
module Spacer
  
  class Play < Chingu::GameState
    trait :timer
    
    def setup
      self.input = { :p => Spacer::Pause }
      
      @player = Player.create
      @player.input = { :holding_left => :move_left, :holding_right => :move_right, :holding_up => :move_up, :holding_down => :move_down, :holding_space => :shoot, :left_control => :missile }
      
      setup_hud
      
      @timer = 100
      @total_ticks = 0
    end

    def setup_hud
      @score_text = Chingu::Text.create("Pontos: 0", :x => 10, :y => 10, :zorder => 55, :size=>20)
    end
    
    def update_hud
      if @player
         update_text_if_needed(@score_text, "Pontos: #{@player.score}")
      end
    end
    
    def update_text_if_needed(text_instance, text)
      text_instance.text = text unless text_instance.text == text
    end
    
    def update
      super
      update_hud
      
      game_objects.destroy_if { |game_object| game_object.respond_to?("outside_window?") && game_object.outside_window? }
      
      @player.each_collision(Enemy) do |player, enemy|
        unless enemy.status == :dying
          enemy.die
          player.die
          after(2000) { push_game_state(Spacer::Gameover) }
        end
      end
      
      Bullet.each_collision(Enemy) do |bullet, enemy|
        bullet.destroy
        if enemy.hit_by(bullet)
          @player.score += 20
        end
      end
      
      @timer = @timer * 0.9999
      @total_ticks += 1
      if @total_ticks > @timer
        Enemy.create(:x => rand(700), :y => 0)
        @total_ticks = 0
      end
          
      $window.caption = "Player x/y: #{@player.x}/#{@player.y} - Score: #{@player.score} - FPS: #{$window.fps} - game objects: #{game_objects.size}"
    end
        
    def draw
      super
      fill Gosu::Color.new(0xFF024994)
    end
  end
end
