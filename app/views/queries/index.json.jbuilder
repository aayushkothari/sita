json.array!(@queries) do |query|
  json.extract! query, :id, :val
  json.url query_url(query, format: :json)
end
