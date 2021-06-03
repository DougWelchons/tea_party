Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

@customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
@tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
@subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
@subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
@subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")
