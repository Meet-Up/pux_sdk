class PostImageFace
	REQ_URL = 'http://eval.api.pux.co.jp:8080'
	REQ_PATH = '/webapi/face.do'

	def post_image_url(api_key, in_url, isPost)
		puts('------------------------------------')
		puts('APIKEY:' + api_key)
		puts('IMAGE:' + in_url)
		url = REQ_URL + REQ_PATH

    	# パラメータの設定
    	values = {
      		'apiKey' => api_key,
      		'imageURL' => in_url
    	}
    	res = ''

   		client = HTTPClient.new

    	begin
      		if isPost then
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

    	# レスポンスの判定
    	if res.instance_of?(HTTP::Message)
      		p(res.status) # ステータスコードが返ってくる
      		p(res.content) # XML(Body)が取得できる
    	end
  	end

  	# inputFile での送信(multipart/form-data)
  	# in_file : ファイルパス
  	def post_file_send(api_key, in_file)
    	puts('------------------------------------')
    	puts('APIKEY:' + api_key)
    	puts('IMAGE:' + in_file)
    	url = REQ_URL + REQ_PATH
    	res = ''
    	# FileをブロックしてOpen
    	File.open(in_file) do |file|
      		values = {
        		'apiKey' => api_key,
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
      		# レスポンスの判定
      		if res.instance_of?(HTTP::Message)
        		p(res.status) # ステータスコードが返ってくる
        		p(res.content) # XML(Body)が取得できる
      		end
    	end
  	end
end

#key = 'RCGHACKA13'
#imageURL = "http://st1.pux.co.jp/test/480x640_w1.jpg"
#imageFile = "test.jpg"
#imageURL = http://lifeboard.jp/img/welcome_creator_akiho.png

#post = PostImageFace.new()
#post.PostImageURL(key, imageURL, true) # POSTリクエスト
#post.PostImageURL(key, imageURL, false) # GETリクエスト
#post.PostFileSend(key, imageFile)  # inputFile での送信(multipart/form-data)
