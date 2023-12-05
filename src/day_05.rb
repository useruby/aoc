# frozen_string_literal: true

class Day05 < Day
  def locations
    transformation_maps = build_maps

    seeds.map do |seed|
      transformation_maps.inject(seed) do |seed_for_transformation, transformation_map|
        mapping(seed_for_transformation, transformation_map)
      end
    end.flatten
  end

  def result
    return locations.min unless enable_part_two

    locations.min_by(&:begin).begin
  end

  private

  def seeds
    key = 'seeds:'
    seeds_data = @input.each do |line|
      break line.delete(key).strip.split.map(&:to_i) if line.start_with?(key)
    end

    return seeds_data unless enable_part_two

    seeds = []

    seeds_data.each_slice(2) do |seed_range_start, range_length|
      seeds << (seed_range_start..seed_range_start + range_length - 1)
    end

    seeds
  end

  def mapping(source, destination_to_source)
    case source
    when Range
      mapping_for_seeds(source, destination_to_source)
    when Array
      source.map { |item| mapping_for_seeds(item, destination_to_source) }.flatten
    when Integer
      mapping_for_seed(source, destination_to_source)
    end
  end

  def mapping_for_seed(seed, destination_to_source)
    destination_to_source.each do |source, offset|
      return seed + offset if source.cover?(seed)
    end

    seed
  end

  def mapping_for_seeds(seed_range, destination_to_source)
    seed_ranges = [seed_range]

    transformed_seeds =
      destination_to_source
      .sort { |(_, source_begin_a, _), (_, source_begin_b, _)| source_begin_a <=> source_begin_b }
      .map do |source, offset|
        seed_ranges.map do |range|
          next if range.begin >= source.end || source.begin >= range.end

          seeds_transformation(range, source, seed_ranges, offset)
        end
      end

    (transformed_seeds.flatten + seed_ranges).compact
  end

  def seeds_transformation(*seeds_source, seed_ranges, offset)
    intersection = (seeds_source.map(&:begin).max..seeds_source.map(&:end).min)
    seeds, = seeds_source

    update_seed_ranges(seeds, intersection, seed_ranges)

    Range.new(*[intersection.begin, intersection.end].map { |value| value + offset })
  end

  def update_seed_ranges(seeds, intersection, seed_ranges)
    seed_ranges.clear
    seed_ranges.push((seeds.begin..intersection.begin)) if seeds.begin != intersection.begin
    seed_ranges.push((intersection.end..seeds.end)) if seeds.end != intersection.end
  end

  def build_maps
    maps = []
    map_name = nil
    map = []

    @input.each do |line|
      next if line.empty?

      map_start = line.match(/^(.*)\s+map:/)
      if map_start
        maps << map if map_name
        map_name = map_start[0]
        map = []
        next
      end

      map << build_mapping(line)
    end

    maps << map
  end

  def build_mapping(line)
    destination_begin, source_begin, length = line.split.map(&:to_i)
    source = (source_begin..source_begin + length - 1)
    destination_source_offset = destination_begin - source_begin

    [source, destination_source_offset]
  end
end
