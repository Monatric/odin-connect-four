# frozen_string_literal: true

# class for the connect four player
class Person
  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end
