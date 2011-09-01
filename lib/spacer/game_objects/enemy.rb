module Spacer
  class Enemy < Chingu::GameObject
    has_traits :collision_detection, :timer
    trait :bounding_box, :debug => false
    attr_reader :status
  
    def setup
      @health = 100
      @status == :default
      @black = Gosu::Color.new(0xFF000000)
    
      @sprite = Chingu::Animation.new(:file => "enemies.png", :width => 33, :height => 33)
      @sprite.frame_names = { :brown => 0..0, :blue => 1..1, :green => 2..2, :white => 3..3, :gray => 4..4 }
      
      @image = @sprite[:green].next
    end
    
    def hit_by(object)
      return if @status == :dying
      
      during(20) { @mode = :additive; }.then { @mode = :default }
      
      if object.bullet == :small
        @health -= 20
      else
        @health = 0
      end
    
      if @health <= 0
        die
        return true
      else
        return false
      end
    end
    
    def die
      return  if @status == :dying
      @status = :dying
      
      @color = @black
      @color.alpha = 50
      during(200) { @factor_x += 0.5; @factor_y += 0.5; @x -= 1; @color.alpha -= 1}.then { self.destroy }
    end
    
    def update
      return if @status == :dying
      @y += 2
    end
  end
end
