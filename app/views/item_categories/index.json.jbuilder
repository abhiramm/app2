json.array!(@item_categories) do |item_category|
  json.extract! item_category, :name
  json.url item_category_url(item_category, format: :json)
end
