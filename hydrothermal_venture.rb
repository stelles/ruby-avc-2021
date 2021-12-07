class Point
  attr_accessor :x
  attr_accessor :y
  attr_accessor :v
  def initialize(x, y, v)
    @x = x
    @y = y
    @v = v
  end

  def to_s
    v > 0 ? (v).to_s : "."
  end
end

class Graph
  attr_accessor :points
  def initialize
    @points = {}
  end

  def point(x,y)
    key = "#{x},#{y}"
    point = points[key]
    # point = @points.find { |p| p.x == x && p.y == y }
    unless point
      point = Point.new(x, y, 0)
      points[key] = point
    end
    point
  end

  def draw_line(v1,v2, o, x: true)
    lower_bound = [v1,v2].min
    upper_bound = [v1,v2].max
    while lower_bound <= upper_bound
      p = if x
            point(lower_bound, o)
          else
            point(o, lower_bound)
          end
      p.v += 1
      lower_bound += 1
    end
  end

  def draw_diag(x1,x2,y1,y2)
    dx = x2-x1
    dy = y2-y1

    while x1 != x2

      p = point(x1, y1)
      p.v += 1

      if dx < 0
        x1 = x1 - 1
      else
        x1 +=1
      end
      if dy < 0
        y1 = y1 - 1
      else
        y1 += 1
      end
    end

    p = point(x1, y1)
    p.v += 1
  end

  def add_line(x1, y1, x2, y2)
    if x1 == x2
      draw_line(y1, y2, x1, x: false)
    elsif y1 == y2
      draw_line(x1, x2, y1, x: true)
    else
      draw_diag(x1,x2,y1,y2)
    end
  end

  def two_count
    points.values.select { |p| p.v >= 2 }.count
  end

  def show
    xmax = points.values.map(&:x).max
    ymax = points.values.map(&:y).max
    puts xmax, ymax
    (0..ymax).each do |y|
      (0..xmax).each do |x|
        p = point(x,y)
        print p
      end
      print "\n"
    end
  end
end


lines = File.readlines('data/hydrothermal_venture.txt', chomp: true)

graph = Graph.new
lines.each do |l|
  ld = l.split("->")
  graph.add_line(*ld[0].split(',').map(&:to_i), *ld[1].split(',').map(&:to_i))
end

graph.show

puts graph.two_count


