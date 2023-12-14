# frozen_string_literal: true

class Day14 < Day
  class ControlPanel
    def initialize(data, cycle = 0)
      @panel = data
      @cycle = cycle
    end

    def tilt(panel)
      Array.new(panel.size) { +'' }.tap do |tilted_panel|
        panel.first.size.times do |column_index|
          empty_rows = []

          panel.size.times do |row_index|
            tilted_panel[row_index][column_index] = panel[row_index][column_index]

            case panel[row_index][column_index]
            when '.'
              empty_rows.push(row_index)
            when '#'
              empty_rows.clear
            when 'O'
              unless empty_rows.empty?
                tilted_panel[empty_rows.shift][column_index] = 'O'
                tilted_panel[row_index][column_index] = '.'
                empty_rows.push(row_index)
              end
            end
          end
        end
      end
    end

    def rotate(panel)
      Array.new(panel.first.size) { +'' }.tap do |rotated_panel|
        panel.reverse.each_with_index do |line, char_index|
          line.chars.each_with_index do |char, line_index|
            rotated_panel[line_index][char_index] = char
          end
        end
      end
    end

    def tilt_and_rotate(panel, count = 4)
      count.times { panel = rotate(tilt(panel)) }
      panel
    end

    def score
      history = []
      panel = @panel
      panel =
        @cycle.times do |cycle_index|
          panel = tilt_and_rotate(panel)

          if history.include?(panel)
            history_index = history.index(panel)
            step = cycle_index - history_index
            offset = (@cycle - history_index - 1) % step

            break history[history_index + offset]
          end

          history << panel
        end

      panel = tilt(@panel) if @cycle.zero?

      panel.reverse.map.with_index { |line, index| line.scan('O').size * (index + 1) }.sum
    end
  end

  def result
    cycle = enable_part_two ? 1_000_000_000 : 0
    ControlPanel.new(@input, cycle).score
  end
end
