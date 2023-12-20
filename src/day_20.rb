# frozen_string_literal: true

class Day20 < Day
  class Component
    attr_reader :name, :destination_components

    def initialize(name, destination_components)
      @name = name
      @destination_components = destination_components
    end

    def send_pulse(type, _previous_component)
      [type, destination_components]
    end
  end

  class FlipFlop < Component
    def initialize(name, destination_components)
      super

      @off = true
    end

    def toggle_off
      @off = !@off
    end

    def send_pulse(type, _previous_component)
      return if type == :high

      toggle_off

      [(@off ? :low : :high), destination_components]
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
        destination_components
      ]
    end
  end

  class Broadcaster < Component
    def initialize(_name, destination_components)
      super('broadcaster', destination_components)
    end
  end

  class ComponentBuilder
    TYPES = {
      'broadcaster' => Broadcaster,
      '%' => FlipFlop,
      '&' => Conjunction
    }.freeze

    def self.create_component(label, destination_components)
      match = label.match(/(?<type>broadcaster|%|&)(?<name>\w*)/)
      TYPES[match[:type]].new(match[:name], destination_components)
    end
  end

  def result
    load_components
    init_inputs_of_conjunctions

    return 1 if enable_part_two

    1000.times { click_button }
    count_pulse(:result)
  end

  def click_button
    queue = [[@components['broadcaster'], :low, nil]]

    until queue.empty?
      component, pulse, previous_component = queue.pop

      count_pulse(pulse)

      next unless component.is_a?(Component)

      received_pulse, destination_components = component.send_pulse(pulse, previous_component)
      destination_components&.each do |component_name|
        next_component = @components[component_name]
        queue << [next_component || component_name, received_pulse, component]
      end
    end
  end

  def count_pulse(pulse)
    return @pulse_count.inject(:*) if pulse == :result

    @pulse_count ||= [0, 0] # low, high
    @pulse_count[pulse == :low ? 0 : 1] += 1
  end

  def load_components
    @components = @input.to_h do |line|
      label, destination_components = line.split(' -> ')
      component = ComponentBuilder.create_component(label, destination_components.split(',').map(&:strip))
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
          .select { |component| component.destination_components.include?(conjunction.name) }
          .map(&:name)
      end
  end
end
