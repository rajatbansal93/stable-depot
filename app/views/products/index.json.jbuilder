json.array!(@products) do |product|
  json.extract! product,  :title
  json.extract! product.category.name if product.category
  json.url product_url(product, format: :json)
end
