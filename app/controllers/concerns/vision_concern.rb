module VisionConcern
  extend ActiveSupport::Concern
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def vision_face_detect(file, confidence_threshold)
    begin
      base64 = Base64.strict_encode64(file)
      engine = Engine.where(engine_type: :capture).sample

      uri = URI.parse("http://#{engine.external_address}/face_analysis")

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
      logger.error 'IFACE CANNOT FACE DETECT'
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
    rescue => e
      logger.error 'MILVUS CANNOT CREATE VECTOR'
    end
  end

  def milvus_delete_vector(collection_name, vector_id)
    begin
      milvus_address = ENV['MILVUS_ADDRESS'] ? ENV['MILVUS_ADDRESS'] : 'localhost:19121'

      uri = URI.parse("http://#{milvus_address}/collections/#{collection_name}/vectors")
      data = { delete: { ids: [vector_id.to_s] } }

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      header = { "Content-Type": "application/json" }
      request = Net::HTTP::Put.new(uri.request_uri, header)
      request.body = data.to_json

      response = http.request(request)
      response.body
    rescue => e
      puts e
      puts 'MILVUS CANNOT DELETE VECTOR'
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
      logger.error 'MILVUS CANNOT SEARCH IN COLLECTION'
      []
    end
  end

  def milvus_confidence(distance)
    1 / (1 + Math.exp(4 * -distance.to_f.abs))
  end

end