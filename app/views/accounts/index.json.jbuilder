json.array!(@accounts) do |account|
  json.extract! account, :id, :username, :twitter_id, :display_name, :followers_count, :following_count, :party_id
  json.url account_url(account, format: :json)
end
