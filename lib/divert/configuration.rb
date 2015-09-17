module Divert
  class Configuration
    attr_accessor :save_to_db

    def initialize
      @save_to_db = true
    end
  end
end
