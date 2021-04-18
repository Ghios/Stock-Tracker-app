class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: 'Tpk_989938e87baf4ffda3615f295f94f1f1',
            secret_token: 'Tsk_1817eda31ed2439ca71952f78539e776',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        begin
          new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol) )
        rescue => exception
          return nil 
        end
      end
end
