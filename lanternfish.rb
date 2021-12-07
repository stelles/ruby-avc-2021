class Fishes
  def initialize(values)
    @fish_count = Hash.new(0)
    values.each { |v| @fish_count[v.to_i] += 1}
  end

  def fish_fuckin!
    before = @fish_count.clone
    nf = @fish_count[0]
    (1..8).each do |c|
      @fish_count[c - 1] = @fish_count[c]
    end
    @fish_count[6] += nf
    @fish_count[8] = nf
  end

  def fish_sum
    @fish_count.values.sum
  end
end

data = File.readlines('data/lanternfish')

fish = data.first.split(',')

school = Fishes.new(fish)

(1..256).each do |day|
  school.fish_fuckin!
  puts "Day: #{day} #{school.fish_sum}"
end

