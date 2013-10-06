json.array!(@points) do |point|
  json.extract! point, :latitude, :longitude, :speed, :height, :course, :accuracy, :provider, :timefix
  json.url point_url(point, format: :json)
end
