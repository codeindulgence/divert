module Divert
  class Redirect < ActiveRecord::Base
    # Validations
    validates :hither, presence:true

    # Instance Methods
    def name
      "\"#{hither}\" > \"#{thither}\""
    end

    def hit
      return nil unless active
      increment! :hits unless thither
      thither
    end

    # Class Methods
    def self.hit path
      path.chomp! '/'
      find_or_create_by(hither: path).hit
    end

    # Scopes
    scope :active, :conditions => {:active => true}
  end
end
