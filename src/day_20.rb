# frozen_string_literal: true

class Day20 < Day
  class Component
    attr_reader :name, :outputs

    def initialize(name, outputs)
      @name = name
      @outputs = outputs
    end

    def send_pulse(type, _)
      [type, outputs]
    end
  end

  class FlipFlop < Component
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

  class Conjunction < Component
    def inputs=(components_names)
      @input_components = components_names.to_h { |name| [name, :low] }
    end

    def send_pulse(type, input_component)
      @input_components[input_component.name] = type

      [
        @input_components.values.all?(:high) ? :low : :high,
        outputs
      ]
    end
  end

  class Broadcaster < Component
    def initialize(_, outputs)
      super('broadcaster', outputs)
    end
  end

  class ComponentBuilder
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
    load_components
    init_inputs_of_conjunctions

    return result_part_two if enable_part_two

    1000.times { click_button }
    count_pulse(:result)
  end

  def result_part_two
    components = @components.values
    @rx_input = components.find { |component| component.outputs.include?(RX) }.name
    @visited = components
               .select { |component| component.outputs.include?(@rx_input) }
               .to_h { |component| [component.name, false] }
    @clicks_counts = {}

    (1..).each do |clicks|
      result = click_button(clicks:)
      break result unless result.nil?
    end
  end

  def click_button(clicks: 1)
    queue = [[@components['broadcaster'], :low, nil]]

    until queue.empty?
      component, pulse, input = queue.shift

      count_pulse(pulse)

      next unless component.is_a?(Component)

      result = count_clicks(component, pulse, input, clicks)
      return result unless result.nil?

      received_pulse, outputs = component.send_pulse(pulse, input)
      outputs&.each do |component_name|
        next_component = @components[component_name]
        queue.push([next_component || component_name, received_pulse, component])
      end
    end
  end

  def count_pulse(pulse)
    return if enable_part_two
    return @pulse_count.inject(:*) if pulse == :result

    @pulse_count ||= [0, 0] # low, high
    @pulse_count[pulse == :low ? 0 : 1] += 1
  end

  def count_clicks(component, pulse, input, clicks)
    return unless enable_part_two

    return unless component.name == @rx_input && pulse == :high

    @visited[input.name] = true
    @clicks_counts[input.name] = clicks

    return unless @visited.values.all?(true)

    result = 1
    @clicks_counts.each_value do |clicks_count|
      result *= clicks_count / result.gcd(clicks_count)
    end

    result
  end

  def load_components
    @components = @input.to_h do |line|
      label, outputs = line.split(' -> ')
      component = ComponentBuilder.build(label, outputs.split(',').map(&:strip))
      [component.name, component]
    end
  end

  def init_inputs_of_conjunctions
    @components
      .values
      .select { |component| component.is_a?(Conjunction) }
      .each do |conjunction|
        conjunction.inputs =
          @components
          .values
          .select { |component| component.outputs.include?(conjunction.name) }
          .map(&:name)
      end
  end
end
