module Api
  module V1
    module Web
      class UserSerializer < ::UserSerializer
        attributes :version_api, :platform, :serializer_path

        def version_api
          "V1"
        end

        def platform
          "Web"
        end

        def serializer_path
          "app/serializers/api/v1/mobile/user_serializer"
        end
      end
    end
  end
end