module Divert
  class Configuration
    attr_accessor :save_to_db
    attr_accessor :redirect_from_view
    attr_accessor :controller

    def initialize
      @save_to_db = true
      @redirect_from_view = false
    end
  end
end
