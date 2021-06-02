require 'rails_helper'

RSpec.describe "POST api/v1/subscriptions" do
  describe "happy Path" do
    it "returns a new subscription with all relivent data" do
      @customer = Customer.create!(first_name: "John", last_name: "Smith", email: "email@domain.com", address: "123 ABC St.")
      @tea = Tea.create!(title: "Mint Madness", description: "All the Mint!", temperature: "212F", brew_time: "3 - 5  minutes")
      subscription_params = { title: "Mint Monthly",
                              price: 25.99,
                              frequency: 2,
                              customer_id: @customer.id,
                              tea_id: @tea.id}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post '/api/v1/subscriptions', headers: headers, params: subscription_params.to_json

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json")
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:id, :type, :attributes])
      expect(body[:data][:id]).to be_a(String)
      expect(body[:data][:type]).to eq('subscription')
      expect(body[:data][:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
      expect(body[:data][:attributes][:title]).to eq("Mint Monthly")
      expect(body[:data][:attributes][:price]).to eq(25.99)
      expect(body[:data][:attributes][:status]).to eq("active")
      expect(body[:data][:attributes][:frequency]).to eq("monthly")
      expect(body[:data][:attributes][:customer_id]).to eq(@customer.id)
      expect(body[:data][:attributes][:tea_id]).to eq(@tea.id)
    end
  end

  describe "Sad Path and Edge Case" do
    it "returns a 400 error if no body is provided" do

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post '/api/v1/subscriptions', headers: headers

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body).to eq({error: "Customer must exist, Tea must exist, Title can't be blank, Price can't be blank, Price is not a number, and Frequency can't be blank"})
    end
  end
end
