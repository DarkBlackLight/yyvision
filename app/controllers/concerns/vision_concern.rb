module VisionConcern
  extend ActiveSupport::Concern
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def vision_face_detect(file, confidence_threshold)
    begin
      base64 = Base64.strict_encode64(file)
      engine = Engine.where(engine_type: :api).sample

      uri = URI.parse("http://#{engine.address}/face_detect")

      data = { data: base64, face_img: true, confidence_threshold: confidence_threshold }

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

  def milvus_create_collection(collection_name)
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections")
      data = { collection_name: collection_name, dimension: 512, metric_type: 'IP' }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = data.to_json

      response = http.request(request)
      results = JSON.parse(response.body)
      results
    rescue
      puts 'MILVUS CANNOT GET COLLECTIONS'
    end
  end

  def milvus_get_collections
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections?offset=0&page_size=10")

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Get.new(uri.request_uri, header)
      response = http.request(request)

      results = JSON.parse(response.body)
      results['collections']
    rescue
      puts 'MILVUS CANNOT GET COLLECTIONS'
    end
  end

  def milvus_drop_collection(collection_name)
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections/#{collection_name}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Delete.new(uri.request_uri, header)
      response = http.request(request)
      response.body
    rescue => e
      puts e
      puts 'MILVUS CANNOT DROP COLLECTION'
    end
  end

  def milvus_create_vector(collection_name, portrait)
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections/#{collection_name}/vectors")
      data = { vectors: [portrait.features], ids: [portrait.id.to_s] }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = data.to_json
      response = http.request(request)
      response.body

      puts response.body
    rescue => e
      puts 'MILVUS CANNOT CREATE VECTOR'
    end
  end

  def milvus_search_vectors(collection_name, portrait, topk = 10)
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections/#{collection_name}/vectors")
      data = { search: { topk: topk, vectors: [portrait.features], params: {} } }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Put.new(uri.request_uri, header)
      request.body = data.to_json
      response = http.request(request)

      results = JSON.parse(response.body)
      results['result'][0] ? results['result'][0] : []
    rescue
      puts 'MILVUS CANNOT SEARCH IN COLLECTION'
      []
    end
  end

  def milvus_confidence(distance)
    1 / (1 + Math.exp(6 * -distance.to_f.abs))
  end

end