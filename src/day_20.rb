# frozen_string_literal: true

class Day20 < Day
  class Block
    attr_reader :name, :outputs

    def initialize(name, outputs)
      @name = name
      @outputs = outputs
    end

    def send_pulse(type, _)
      [type, outputs]
    end
  end

  class FlipFlop < Block
    def initialize(*)
      super

      @off = true
    end

    def toggle_off
      @off = !@off
    end

    def send_pulse(type, _)
      return if type == :high

      toggle_off

      [(@off ? :low : :high), outputs]
    end
  end

  class Conjunction < Block
    def inputs=(blocks_names)
      @input_blocks = blocks_names.to_h { |name| [name, :low] }
    end

    def send_pulse(type, input_block)
      @input_blocks[input_block.name] = type

      [
        @input_blocks.values.all?(:high) ? :low : :high,
        outputs
      ]
    end
  end

  class Broadcaster < Block
    def initialize(_, outputs)
      super('broadcaster', outputs)
    end
  end

  class BlockBuilder
    TYPES = {
      'broadcaster' => Broadcaster,
      '%' => FlipFlop,
      '&' => Conjunction
    }.freeze

    def self.build(label, outputs)
      match = label.match(/(?<type>broadcaster|%|&)(?<name>\w*)/)
      TYPES[match[:type]].new(match[:name], outputs)
    end
  end

  RX = 'rx'

  def result
    load_blocks
    init_inputs_of_conjunctions

    return result_part_two if enable_part_two

    1000.times { click_button }
    count_pulse(:result)
  end

  def result_part_two
    blocks = @blocks.values
    @rx_input = blocks.find { |block| block.outputs.include?(RX) }.name
    @clicks_counts = blocks
                     .select { |block| block.outputs.include?(@rx_input) }
                     .to_h { |block| [block.name, 0] }

    (1..).each do |clicks|
      result = click_button(clicks:)
      break result unless result.nil?
    end
  end

  def click_button(clicks: 1)
    queue = [[@blocks['broadcaster'], :low, nil]]

    until queue.empty?
      block, pulse, input = queue.shift

      count_pulse(pulse)

      next unless block.is_a?(Block)

      result = count_clicks(block, pulse, input, clicks)
      return result unless result.nil?

      emitted_pulse, outputs = block.send_pulse(pulse, input)

      outputs&.each do |block_name|
        next_block = @blocks[block_name]
        queue.push([next_block, emitted_pulse, block])
      end
    end
  end

  def count_pulse(pulse)
    return if enable_part_two
    return @pulse_count.inject(:*) if pulse == :result

    @pulse_count ||= [0, 0] # low, high
    @pulse_count[pulse == :low ? 0 : 1] += 1
  end

  def count_clicks(block, pulse, input, clicks)
    return unless enable_part_two

    return unless block.name == @rx_input && pulse == :high

    @clicks_counts[input.name] = clicks

    return unless @clicks_counts.values.all?(&:positive?)

    @clicks_counts.values.inject(1) do |result, clicks_count|
      result * clicks_count / result.gcd(clicks_count)
    end
  end

  def load_blocks
    @blocks = @input.to_h do |line|
      label, outputs = line.split(' -> ')
      block = BlockBuilder.build(label, outputs.split(',').map(&:strip))
      [block.name, block]
    end
  end

  def init_inputs_of_conjunctions
    @blocks
      .values
      .select { |block| block.is_a?(Conjunction) }
      .each do |conjunction|
        conjunction.inputs =
          @blocks
          .values
          .select { |block| block.outputs.include?(conjunction.name) }
          .map(&:name)
      end
  end
end
