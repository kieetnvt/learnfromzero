module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :total, Float, null: false
    field :payments, [Types::PaymentType], null: false
    field :payments_count, Integer, null: false

    def payments_count
        object.payments.size
    end
  end
end
