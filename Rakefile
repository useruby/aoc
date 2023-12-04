# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = FileList['test/**/*_spec.rb']
  task.verbose = true
end

task default: :test

task :day, [:number] do |_, args|
  number = args[:number]

  next puts('Day is missing!') if number.nil?

  number = format('%02d', number.to_i)

  data_filename = "#{__dir__}/data/#{number}"
  next puts('Input data is missing!') unless File.exist?(data_filename)

  input_data = File.read(data_filename).split("\n")

  require "#{__dir__}/src/record"
  require "#{__dir__}/src/day"
  require "#{__dir__}/src/day_#{number}"

  results = [false, true].map do |flag|
    Object.module_eval(
      "Day#{number}", # "Day01"
      __FILE__,
      __LINE__ - 2
    ).new(input_data, enable_part_two: flag).result
  end
  puts("Results: part one: #{results[0]} part two: #{results[1]}")
end
