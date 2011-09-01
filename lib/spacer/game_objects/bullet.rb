module Spacer
  class Bullet < Chingu::GameObject
    trait :collision_detection
    attr_reader :radius, :bullet
    
    def initialize(options={})
      super({:bullet => :small}.merge(options))
    end
    
    def setup
      @bullet = options[:bullet]
      @sprite = Chingu::Animation.new(:file => "bullets.png", :width => 33, :height => 33)
      @sprite.frame_names = { :double => 0..0, :big => 1..1, :small => 2..2 }
      @radius = 3
      @bullet_velocity = { :small => 4, :double => 1 }
    end
    
    def update
      @y -= @bullet_velocity[@bullet]
      @image = @sprite[@bullet].next
    end
  end
end
