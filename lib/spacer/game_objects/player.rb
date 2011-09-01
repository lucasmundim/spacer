module Spacer
  class Player < Chingu::GameObject
    MOVEMENT_RATE = 2
    trait :velocity
    trait :bounding_box, :scale => 0.75, :debug => false
    trait :timer
    trait :collision_detection
    
    attr_accessor :score
    
    def setup
      @x = $window.width / 2
      @y = $window.height / 2
      
      @animation = Chingu::Animation.new(:file => "plane.png", :width => 66, :height => 66)
      @animation.frame_names = { :default => 0..2 }
      
      @explosion_animation = Chingu::Animation.new(:file => "eplosion.png", :width => 66, :height => 66, :loop => false)
      @explosion_animation.frame_names = { :default => 0..6 }
      
      @last_x, @last_y = @x, @y
      
      @score = 0
      
      @cooling_down = false
    end

    def move_left
      @x -= MOVEMENT_RATE
    end

    def move_right
      @x += MOVEMENT_RATE
    end
    
    def move_up
      @y -= MOVEMENT_RATE
    end
    
    def move_down
      @y += MOVEMENT_RATE
    end
    
    def die
      @die = true
      after(400) { self.destroy; }
    end
    
    def shoot
      return if @cooling_down
      @cooling_down = true
      after(100) { @cooling_down = false }
      
      Bullet.create(:x => self.x, :y => self.y, :test => 1)
    end
    
    def missile
      Bullet.create(:x => self.x, :y => self.y, :bullet => :double)
    end
    
    def update
      super

      unless @die
        @image = @animation[:default].next
      else
        @image = @explosion_animation[:default].next
      end
      
      @x, @y = @last_x, @last_y if outside_window?  # return to previous coordinates if outside window
      @last_x, @last_y = @x, @y      
    end
  end
end
