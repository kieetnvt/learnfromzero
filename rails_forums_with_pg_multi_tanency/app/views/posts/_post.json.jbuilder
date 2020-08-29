json.extract! post, :id, :topic_id, :content, :inline_images, :created_at, :updated_at
json.url post_url(post, format: :json)
