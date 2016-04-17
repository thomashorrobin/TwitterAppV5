json.array!(@parties) do |party|
  json.extract! party, :id, :party_name, :party_colour
  json.url party_url(party, format: :json)
end
