module Divert
  class Configuration
    attr_accessor :save_to_db
    attr_accessor :controller

    def initialize
      @save_to_db = true
    end
  end
end
