require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:order)}
    it { should belong_to(:item)}
  end

  describe 'validations' do
    it { should validate_presence_of(:order_id)}
    it { should validate_presence_of(:item_id)}
    it { should validate_presence_of(:quantity)}
    it { should validate_presence_of(:order_price)}
    it { should validate_presence_of(:fulfilled)}
  end
end
