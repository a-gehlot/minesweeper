require_relative "./Tile.rb"

class Board

    DELTAS = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]


    attr_reader :grid

    def empty_grid
        @grid = Array.new(9) { Array.new(9) }
    end

    def populate_board
        (0...9).each do |row|
            (0...9).each do |cell|
                @grid[row][cell] = Tile.new("E")
            end
        end

        while num_mines < 10
            @grid[rand(0...9)][rand(0...9)] = Tile.new("B")
        end

    end

    def num_mines
        @grid.flatten.count { |tile| tile.bomb? }
    end

    def [](arr)
        @grid[arr[0]][arr[1]]
    end
    
    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def render_cheat
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            row_val = row.map { |tile| tile.value }
            puts "#{i} #{row_val.join(" ")}"
        end
    end

    def neighbor_coords(point)
        p_i, p_j = point
        neighbors = []
        DELTAS.each do |d_i, d_j|
            neighbor = [(p_i + d_i), (p_j + d_j)]
            neighbors << neighbor if self.in_bounds?(neighbor)
        end
        neighbors
    end

    def in_bounds?(coords)
        i, j = coords
        0 <= i && i <= 8 && 0 <= j && j <= 8
    end
    

end