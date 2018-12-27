require 'rails_helper'

describe 'as a merchant user' do
  context 'when I visit my dashboard' do
    it 'should show me my profile data, but I cannot edit it' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_path

      expect(page).to have_content(merch.name)
      expect(page).to have_content(merch.street)
      expect(page).to have_content(merch.city)
      expect(page).to have_content(merch.state)
      expect(page).to have_content(merch.zip)
      expect(page).to have_content(merch.email)
      expect(page).to have_link('My Items')
      expect(page).to_not have_link('Edit Profile')
    end
    
    it 'should show me a list of pending orders containing my items' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to recieve(current_user).and_return(merchant)
      
      order_1 = create(:order)
      item_1 = create(:unfulfilled_order_item, order: order_1)
      item_2 = create(:unfulfilled_order_item, order: order_1)      
      
      visit dashboard_path
      
      within "#pending-order-#{order_1.id}" do
        expect(page).to have_link("Order ##{order_1.id}")
        expect(page).to have_content("Placed on: #{order_1.created_at}")
        expect(page).to have_content("My items in order: #{order_1.my_items_quantity}")
        expect(page).to have_content("My items value: #{order_1.my_items_value}")
        click_link "Order ##{order_1.id}"
      end
      
      expect(current_path).to eq(dashboard_orders_path(order_1))
      
    end
  end
end
