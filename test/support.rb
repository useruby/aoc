# frozen_string_literal: true

require 'minitest/autorun'

require "#{__dir__}/../src/record.rb"
Dir["#{__dir__}/../src/day*.rb"].sort.each { |file| require file }

module Minitest
  class Spec
    def self.it_returns_correct_result
      it { _(subject.result).must_equal(result) }
    end
  end
end