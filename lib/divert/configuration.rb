module Divert
  class Configuration
    attr_accessor :save_to_db
    attr_accessor :redirect_clientside
    attr_accessor :controller

    def initialize
      @save_to_db = true
      @redirect_clientside = false
    end
  end
end
