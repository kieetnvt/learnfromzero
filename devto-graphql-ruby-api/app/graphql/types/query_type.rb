module Types
  class QueryType < Types::BaseObject
    field :all_orders, [Types::OrderType], null: false

    def all_orders
      Order.all
    end
  end
end
