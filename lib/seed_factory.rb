class SeedFactory
  class << self
    def create_seed_from_file(file_name)
      @rows = File.read(file_name).split("\n")

      raise StandardError.new('empty file') if @rows.empty?

      @y_length = @rows.length
      @x_length = @rows[0].split.length
      @seed = Array.new(@y_length){ Array.new(@x_length) }
      create_seed_from_text

      @seed
    end

    def create_random_seed(x_length, y_length, life_chance)
      @x_length = x_length
      @y_length = y_length
      @life_chance = life_chance

      validate_random_seed_configuration
      
      @seed = Array.new(@y_length){ Array.new(@x_length) }
      fill_seed_with_random_values
      
      @seed
    end

    private
  
      def create_seed_from_text
        @rows.each_index do |y_index|
          cells = @rows[y_index].split
      
          raise StandardError.new('rows should be of the same size') unless cells.length == @x_length
      
          cells.each_with_index do |cell_character, x_index|
            cell = cell_character.eql?("#")
            @seed[y_index][x_index] = cell
          end
        end
      end
    
      def fill_seed_with_random_values
        @seed.each_index do |y_index|
          @seed[y_index].each_index do |x_index|
            random_number = rand(1..100)
            alive = random_number >= 1 && random_number <= @life_chance
            @seed[y_index][x_index] = alive
          end
        end
      end
    
      def validate_random_seed_configuration
        if @x_length <= 0
          raise ArgumentError.new('Width must be greater than 0.')
        elsif @y_length <= 0
          raise ArgumentError.new('Height must be greater than 0.')
        elsif @life_chance <= 0 or @life_chance > 100
          raise ArgumentError.new('Life chance must be between 1 and 100.')
        end
      end
    end
end