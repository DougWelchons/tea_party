require 'rails_helper'

RSpec.describe "GET api/v1/customers/:customer_id/subscriptions" do
  describe "happy Path" do
    it "returns all of a customers active and canceled subscriptions by default" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      @subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].count).to eq(3)
      expect(body[:data].first).to be_a(Hash)
      expect(body[:data].first.keys).to eq([:id, :type, :attributes])
      expect(body[:data].first[:id]).to be_a(String)
      expect(body[:data].first[:type]).to eq('subscription')
      expect(body[:data].first[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(body[:data].first[:attributes][:title]).to eq("Mint Monthly")
      expect(body[:data].first[:attributes][:price]).to eq(25.99)
      expect(body[:data].first[:attributes][:status]).to eq("active")
      expect(body[:data].first[:attributes][:frequency]).to eq("monthly")
      expect(body[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(body[:data].first[:attributes][:tea_id]).to eq(@tea.id)
    end

    it "returns an empty array if customer has no subscriptions" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].count).to eq(0)
    end

    it "returns only the active subscriptions if the status param equals active" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      @subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")

      get "/api/v1/customers/#{@customer.id}/subscriptions?status=active"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].count).to eq(2)
      expect(body[:data].first).to be_a(Hash)
      expect(body[:data].first.keys).to eq([:id, :type, :attributes])
      expect(body[:data].first[:id]).to be_a(String)
      expect(body[:data].first[:type]).to eq('subscription')
      expect(body[:data].first[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(body[:data].first[:attributes][:title]).to eq("Mint Monthly")
      expect(body[:data].first[:attributes][:price]).to eq(25.99)
      expect(body[:data].first[:attributes][:status]).to eq("active")
      expect(body[:data].first[:attributes][:frequency]).to eq("monthly")
      expect(body[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(body[:data].first[:attributes][:tea_id]).to eq(@tea.id)
    end

    it "returns only the canceled subscriptions if the status param equals canceled" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      @subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")

      get "/api/v1/customers/#{@customer.id}/subscriptions?status=canceled"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].count).to eq(1)
      expect(body[:data].first).to be_a(Hash)
      expect(body[:data].first.keys).to eq([:id, :type, :attributes])
      expect(body[:data].first[:id]).to be_a(String)
      expect(body[:data].first[:type]).to eq('subscription')
      expect(body[:data].first[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(body[:data].first[:attributes][:title]).to eq("Twice Mint")
      expect(body[:data].first[:attributes][:price]).to eq(25.99)
      expect(body[:data].first[:attributes][:status]).to eq("canceled")
      expect(body[:data].first[:attributes][:frequency]).to eq("biweekly")
      expect(body[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(body[:data].first[:attributes][:tea_id]).to eq(@tea.id)
    end

    it "returns all of the subscriptions if the status param is blank" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      @subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")

      get "/api/v1/customers/#{@customer.id}/subscriptions?status="

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].count).to eq(3)
      expect(body[:data].first).to be_a(Hash)
      expect(body[:data].first.keys).to eq([:id, :type, :attributes])
      expect(body[:data].first[:id]).to be_a(String)
      expect(body[:data].first[:type]).to eq('subscription')
      expect(body[:data].first[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(body[:data].first[:attributes][:title]).to eq("Mint Monthly")
      expect(body[:data].first[:attributes][:price]).to eq(25.99)
      expect(body[:data].first[:attributes][:status]).to eq("active")
      expect(body[:data].first[:attributes][:frequency]).to eq("monthly")
      expect(body[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(body[:data].first[:attributes][:tea_id]).to eq(@tea.id)
    end

  end

  describe "Sad Path and Edge Case" do
    it "returns a 404 error if the customer does not exist" do
      get "/api/v1/customers/1/subscriptions"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to eq({error: "Couldn't find Customer with 'id'=1"})
    end

    it "returns a 400 error if the status param not a valid status" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      @subscription1 = Subscription.create!(title: "Mint Monthly", price: 25.99, frequency: 2, customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Mint", price: 25.99, frequency: 0, customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Twice Mint", price: 25.99, frequency: 1, customer_id: @customer.id, tea_id: @tea.id, status: "canceled")

      get "/api/v1/customers/#{@customer.id}/subscriptions?status=something_else"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body).to eq({error: "status can only be canceled or active"})
    end
  end
end
