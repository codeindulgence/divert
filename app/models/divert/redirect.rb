module Divert
  class Redirect < ActiveRecord::Base
    ANTISLASH = /^\/|\/\s*$/

    # Validations
    validates :hither, presence:true

    # Callbacks
    before_save :check_slashes

    # Instance Methods
    def name
      "\"#{hither}\" > \"#{thither}\""
    end

    def hit
      return nil unless active
      self.increment! :hits unless self.thither
      self.thither
    end

    # Class Methods
    def self.hit path
      find_or_create_by_hither(
        path.gsub ANTISLASH,
        :hither => path, :hits => 0
      ).hit
    end

    # Scopes
    scope :active, :conditions => {:active => true}

   private

    def check_slashes
      self.hither = self.hither.gsub ANTISLASH, ''
      self.thither = "/#{self.thither}" unless self.thither.match /^\// unless self.thither.nil?
    end
  end
end
