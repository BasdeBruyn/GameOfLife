class Cell
  def initialize
    @alive = false
    @will_be_alive = false
  end
  
  def will_be_alive
    @will_be_alive
  end
  
  def is_alive
    @alive
  end
  
  def resurrect
    @will_be_alive = true
  end
  
  def die
    @will_be_alive = false
  end

  def determine_life_state
    @alive = @will_be_alive
  end
  
  def to_s
    if @alive
      "#"
    else
      "."
    end
  end
end