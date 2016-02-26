json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :url, :image_url, :price, :category, :subcategory, :rating
  json.url book_url(book, format: :json)
end
