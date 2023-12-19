# frozen_string_literal: true

class Day19 < Day
  A_R = %w[A R].freeze
  XMAS = (1...4001)
  X_M_A_S = %w[x m a s].freeze

  def result
    load_data(enable_part_two)

    enable_part_two ? result_part_two : result_part_one
  end

  def result_part_two
    accepted_blocks = []
    blocks = [['in', X_M_A_S.product([XMAS]).to_h, 0]]

    until blocks.empty?
      rule_name, xmas, rule_index = blocks.pop

      next if rule_name == 'R'
      next accepted_blocks << xmas if rule_name == 'A'

      next_rule_name, condition = @rules[rule_name][rule_index]
      next blocks << [next_rule_name, xmas, 0] if condition.nil?

      match = condition.match(/(?<letter>[x|mas])(?<sign><|>)(?<number>[0-9]+)/)
      letter = match[:letter]
      numbers_range = xmas[letter]
      number = match[:number].to_i

      case [match[:sign], numbers_range.include?(number)]
      when ['>', true]
        blocks << [rule_name, xmas.merge(letter => (numbers_range.begin...(number + 1))), rule_index + 1]
        blocks << [next_rule_name, xmas.merge(letter => ((number + 1)...numbers_range.end)), 0]
      when ['<', true]
        blocks << [rule_name, xmas.merge(letter => (number...numbers_range.end)), rule_index + 1]
        blocks << [next_rule_name, xmas.merge(letter => (numbers_range.begin...number)), 0]
      when ['>', false]
        blocks << [rule_name, xmas, 0] if number < numbers_range.begin
      when ['<', false]
        blocks << [rule_name, xmas, 0] if number >= numbers_range.end
      end
    end

    accepted_blocks.sum do |accepted_block|
      Enumerator::Product.new(*accepted_block.fetch_values(*X_M_A_S)).size
    end
  end

  def result_part_one
    @parts.sum do |part|
      rule_name = 'in'
      x = m = a = s = 0

      until A_R.include?(rule_name)
        rule = @rules[rule_name]
        part.each { |key, value| Module.module_eval("#{key} = #{value}", __FILE__, __LINE__) }
        rule.each do |next_rule_name, condition|
          break rule_name = next_rule_name if condition.nil? || Module.module_eval(condition)
        end
      end

      next 0 if rule_name == 'R'

      x + m + a + s
    end
  end

  private

  def add_rule(line)
    @rules = {} if @rules.nil?

    match = line.match(/(?<name>.*)\{(?<conditions>.*)\}/)
    @rules[match[:name]] = match[:conditions].split(',').map { |rule| rule.split(':').reverse }
  end

  def add_part(line)
    @parts = [] if @parts.nil?

    @parts << line
              .gsub(/{|}/, '')
              .split(',')
              .map { |item| item.split('=') }
              .map { |name, value| [name, value.to_i] }
  end

  def load_data(skip_parts)
    rules_block = true

    @input.each do |line|
      if line.empty?
        rules_block = false
        skip_parts ? break : next
      end

      rules_block ? add_rule(line) : add_part(line)
    end
  end
end
