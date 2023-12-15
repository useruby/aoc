# frozen_string_literal: true

class Day15 < Day
  def result
    sequence = @input.first.split(',')

    case (enable_part_two ? :part_two : :part_one)
    when :part_one
      sequence.sum { |item| hash(item) }
    when :part_two
      result_part_two(sequence)
    end
  end

  private

  def result_part_two(sequence)
    boxes = Array.new(256) { [] }

    sequence.each do |item|
      step = item.match(/(?<label>\w+)(?<operation>[=|-])(?<focal_length>\d?)/)
      box_index = hash(step[:label])
      box = boxes[box_index]

      delete_lens(box, step[:label]) if step[:operation] == '-'
      insert_lens(box, step[:label], step[:focal_length]) if step[:operation] == '='
    end

    boxes.map.with_index do |box, box_index|
      box.map.with_index { |lens, lens_index| (box_index + 1) * (lens_index + 1) * lens.split.last.to_i }.sum
    end.sum
  end

  def hash(string)
    string.bytes.reduce(0) do |sum, byte|
      sum += byte
      (sum * 17) % 256
    end
  end

  def delete_lens(box, lens_label)
    box.delete_if { |lens| lens.split.first == lens_label }
  end

  def insert_lens(box, lens_label, focal_length)
    lens = "#{lens_label} #{focal_length}"

    lens_index = box.index { |box_lens| box_lens.split.first == lens_label }
    lens_index ? box[lens_index] = lens : box.push(lens)
  end
end
