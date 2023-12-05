# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = FileList['test/**/*_spec.rb']
  task.verbose = true
end

task default: :test

def day_number(args)
  number = args[:number]
  return puts('Day is missing!') if number.nil?

  format('%02d', number.to_i)
end

task :day, [:number] do |_, args|
  number = day_number(args)
  next if number.nil?

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

task :generate_day, [:number] do |_, args|
  number = day_number(args)

  spec_filename = "#{__dir__}/test/day_#{number}_spec.rb"
  if File.exist?(spec_filename)
    puts 'Day is already exists!'
    next
  end

  spec_template = <<~SPEC
    # frozen_string_literal: true

    require "\#{__dir__}/support"

    describe Day#{number} do
      describe 'part one' do
        subject { Day#{number}.new(input) }

        let(:result) { 1 }
        let(:input) do
          [
          ]
        end

        it_returns_correct_result
      end

      describe 'part two' do
        subject { Day#{number}.new(input, enable_part_two: true) }

        let(:result) { 2 }
        let(:input) do
          [
          ]
        end

        it_returns_correct_result
      end
    end
  SPEC

  File.write(spec_filename, spec_template)
end
