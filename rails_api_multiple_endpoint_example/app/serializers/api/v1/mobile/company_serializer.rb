module Api
  module V1
    module Mobile
      class CompanySerializer < ActiveModel::Serializer
        attributes :name, :version_api, :platform, :serializer_path

        class TestSerializer < ActiveModel::Serializer
          attribute :id
        end

        has_many :users, serializer: TestSerializer

        def version_api
          "V1"
        end

        def platform
          "Mobile"
        end

        def serializer_path
          "app/serializers/api/v1/mobile/company_serializer"
        end

        class UserSerializer < ActiveModel::Serializer
          attribute :name
        end


      end
    end
  end
end
