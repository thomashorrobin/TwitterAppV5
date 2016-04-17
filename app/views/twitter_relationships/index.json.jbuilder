json.array!(@twitter_relationships) do |twitter_relationship|
  json.extract! twitter_relationship, :id, :follower, :followed
  json.url twitter_relationship_url(twitter_relationship, format: :json)
end
