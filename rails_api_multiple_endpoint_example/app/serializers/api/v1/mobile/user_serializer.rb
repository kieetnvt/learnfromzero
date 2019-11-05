module Api
  module V1
    module Mobile
      class UserSerializer < ::UserSerializer
        attributes :version_api, :platform, :serializer_path
        has_many :skills

        def version_api
          "V1"
        end

        def platform
          "Mobile"
        end

        def serializer_path
          "app/serializers/api/v1/mobile/user_serializer"
        end
      end
    end
  end
end
