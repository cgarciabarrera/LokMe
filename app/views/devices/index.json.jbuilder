json.array!(@devices) do |device|
  json.extract! device, :imei, :name, :last_seen
  json.url device_url(device, format: :json)
end
