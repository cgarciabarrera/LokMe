json.array!(@shareds) do |shared|
  json.extract! shared, :device_id, :user_id, :user_shared, :from_date, :to_date, :visibility
  json.url shared_url(shared, format: :json)
end
