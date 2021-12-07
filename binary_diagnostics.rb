binaries = File.readlines("data/binary_diagnostics.txt", chomp: true)

def binary_to_int(bits)
	bits.each_char.reverse_each.with_index.inject(0) {|v,(dig,i)| v +
		(dig == '1' ? 2**i : 0 )}
end


def determine_bits(ones, zeros, default_bit)
	if ones.count == zeros.count
		return ones if default_bit == '1' else zeros
	end

	if default_bit == '1'
		return ones if ones.count > zeros.count
		return zeros
	else
		return ones if ones.count < zeros.count
		return zeros
	end
end

def get_ones_and_zeros(binaries, default_bit)
	
	(0..binaries[0].length).each do |bit_index|
		ones = []
		zeros = []
		binaries.each do |bits|
			bit = bits[bit_index]
			if bit == '1'
				ones << bits
			else
				zeros << bits
			end
		end

		binaries = determine_bits(ones, zeros, default_bit)

		break if binaries.count == 1
	end

	return binaries.first
end

# binaries = %w(
# 00100
# 11110
# 10110
# 10111
# 10101
# 01111
# 00111
# 11100
# 10000
# 11001
# 00010
# 01010
# )

test_bits = "01010"
puts "Test: #{test_bits} : #{binary_to_int(test_bits)}"

puts "GETTING OXY::"
oxygen = get_ones_and_zeros(binaries, '1')
puts "GETTING C02::"
co2 = get_ones_and_zeros(binaries, '0')
oxygen_val = binary_to_int(oxygen)
co2_val = binary_to_int(co2)
puts "oxygen: #{oxygen_val} - #{oxygen}"
puts "co2: #{co2_val} - #{co2}"

puts binary_to_int(co2) * binary_to_int(oxygen)
