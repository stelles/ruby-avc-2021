class Point
	def initialize(pos, val)
		@pos = pos
		@val = val
		@marked = false
	end

	def val
		@val
	end

	def num
		@val.to_i
	end

	def mark!
		@marked = true
	end

	def marked?
		@marked
	end

	def x
		@pos / 5
	end

	def y
		@pos % 5
	end

	def to_s
		"#{@val}#{@marked}"
	end
end

class BingoBoard

	def initialize(board_numbers)
		@board = board_numbers.map.with_index { |p, i| Point.new(i, p) }
	end

	def mark(val)
		p = @board.find { |p| p.val == val }
		p.mark! if p
	end

	def win?
		(0..4).each do |x|
			start = x * 5
			# fin = ((x + 1) * 5) - 1
			row = @board.slice(start, 5)
			return true if row.all?(&:marked?)
			column = @board.select {|p| p.y == x }
			return true if column.all?(&:marked?)
		end
		false
	end

	def sum_unmarked
		unmarked = @board.select { |p| !p.marked? }
		nums = unmarked.map(&:num)
		nums.sum
	end

end


bingo_file = File.open('data/giant_squid.txt')

inputs = bingo_file.readline()

all_board_data = bingo_file.read().split()


boards = []
while all_board_data.count > 0 do
	board_data = all_board_data.slice!(0..24)
	boards << BingoBoard.new(board_data)
end

won_boards = []
inputs.split(',').each do |move|
	boards.each do |b|
		b.mark move
		if b.win?
      won_boards << b unless won_boards.include? b
      if won_boards.count == boards.count
				puts move.to_i * b.sum_unmarked
				exit 0
      end
		end
	end
end

