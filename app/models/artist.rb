class Artist < ApplicationRecord
    self.primary_key = 'id'
    has_many :album
end
