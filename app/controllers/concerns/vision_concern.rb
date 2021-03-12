module VisionConcern
  extend ActiveSupport::Concern
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def iface_face_detect(file)
    begin
      base64 = Base64.strict_encode64(file)
      engine = Engine.where(engine_type: :api).sample

      uri = URI.parse("http://#{engine.address}/face_detect")

      data = { data: base64, face_img: true }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = data.to_json
      response = http.request(request)

      faces = JSON.parse(response.body)
      faces["data"]
    rescue
      puts 'IFACE CANNOT FACE DETECT'
    end
  end

  def iface_faces_search(faces, source_type)
    begin
      engine = Engine.where(engine_type: :api).sample

      uri = URI.parse("http://#{engine.address}/face_search")
      data = { data: faces.as_json(only: [:features]), source_type: source_type }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = data.to_json
      response = http.request(request)

      results = JSON.parse(response.body)
      results['data']
    rescue
      puts 'IFACE CANNOT FACE POST'
    end
  end

  def iface_faces_post(faces, source_type)
    Engine.where(engine_type: :api).each do |engine|
      begin
        uri = URI.parse("http://#{engine.address}/face_post")
        data = { data: faces.as_json(only: [:id, :features]), source_type: source_type }

        http = Net::HTTP.new(uri.host, uri.port)
        http.read_timeout = 600
        header = { "Content-Type": "application/json" }
        request = Net::HTTP::Post.new(uri.request_uri, header)
        request.body = data.to_json
        response = http.request(request)

        response.body
      rescue
        puts 'IFACE CANNOT FACE POST'
      end
    end
  end

end