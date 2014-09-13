require "httpclient"
require "crack"

module PuxSDK
  class PostImageFace
    REQ_URL = 'http://eval.api.pux.co.jp:8080'
    REQ_PATH = '/webapi/face.do'

    def initialize(api_key)
      @api_key = api_key
    end

    def post_image_url(in_url, to_hash=true, post=false)
      url = REQ_URL + REQ_PATH

      # パラメータの設定
      values = {
          'apiKey' => @api_key,
          'imageURL' => in_url
      }
      res = ''

      client = HTTPClient.new

      begin
        if post then
          # POST送信
          # POSTデータはHTTPClient内でURLEncodeされる
          res = client.post(url, values)
        else
          # GET送信
          # パラエータはQueryとしてリクエストされる
          # QueryStringはHTTPClient内でURLEncodeされる
          res = client.get(url, values)
        end
      rescue => e
          puts('We failed to reach a server.')
          puts(e)
      end
      self.get_response(res, to_hash)
    end

    # inputFile での送信(multipart/form-data)
    # in_file : ファイルパス
    def post_file_send(in_file)
      url = REQ_URL + REQ_PATH
      res = ''
      # FileをブロックしてOpen
      File.open(in_file) do |file|
        values = {
          'apiKey' => @api_key,
          'inputFile' => file
        }
        # HTTPClientの生成
        client = HTTPClient.new

        # client.debug_dev=STDOUT #デバックデータの出力先として「STDOUT」を設定
        begin
          # POST送信
          # POSTデータはHTTPClient内でmultipartとしてリクエストされる
          res = client.post(url, values)
        rescue => e
          puts('We failed to reach a server.')
          puts(e)
        end
      end
      self.get_response(res, to_hash)
    end

    def get_response(response, to_hash)
      return nil if response.nil? || response.content.nil?
      if to_hash
        Crack::XML.parse(response.content)
      else
        response.content
      end
    end
  end
end
