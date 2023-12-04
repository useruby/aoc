# frozen_string_literal: true

class Record
  attr_reader :id

  def initialize(id, payload)
    @id = id
    @payload = payload

    setup
  end

  def self.create(line)
    record_name, payload = line.split(':')

    _, id = record_name.split
    new(id.to_i, payload)
  end

  private

  def setup; end
end
