# frozen_string_literal: true

class Day12 < Day
  def result
    @input.sum do |line|
      @cache = {}
      template, configuration = line.split
      configuration = configuration.split(',').map(&:to_i)

      if enable_part_two
        template = ([template] * 5).join('?')
        configuration *= 5
      end

      number_of_arrangement(template, configuration)
    end
  end

  private

  def number_of_arrangement(template, configuration, template_index = 0, configuration_index = 0, block_size = 0)
    cache_key = [template_index, configuration_index, block_size]
    return @cache[cache_key] if @cache.key?(cache_key)

    @cache[cache_key] =
      number_of_arrangement_without_cache(template, configuration, template_index, configuration_index, block_size)
  end

  def number_of_arrangement_without_cache(template, configuration, template_index, configuration_index, block_size)
    template_item = template[template_index]

    if template_item.nil?
      return 1 if configuration_index == configuration.size - 1 && configuration[configuration_index] == block_size
      return 1 if configuration[configuration_index].nil? && block_size.zero?

      return 0
    end

    %w[. #].inject(0) do |result, char|
      next result unless template_item == char || template_item == '?'

      params =
        case char
        when '.'
          if block_size.zero?
            [template_index + 1, configuration_index, 0]
          elsif configuration[configuration_index] == block_size
            [template_index + 1, configuration_index + 1, 0]
          end
        when '#'
          [template_index + 1, configuration_index, block_size + 1]
        end

      params.nil? ? result : result + number_of_arrangement(template, configuration, *params)
    end
  end

  # works only with part one
  def number_of_arrangement_brute_force(template, configuration)
    %w[. #].repeated_permutation(template.scan('?').size).count do |combination|
      record = String.new(template)
      combination.each { |item| record.sub!('?', item) }

      record.split('.').map(&:size).reject(&:zero?) == configuration
    end
  end
end
