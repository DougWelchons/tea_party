require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
