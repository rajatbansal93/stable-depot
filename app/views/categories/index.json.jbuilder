json.array!(@categories) do |category|
  json.extract! category, :id, :name, :count
  json.url category_url(category, format: :json)
end
