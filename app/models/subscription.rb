class Subscription < ApplicationRecord
  belongs_to :customers
  belongs_to :teas
end
