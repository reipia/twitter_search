#require 'open-uri'
#require 'net/http'
require 'twitter'


class TweetsController < ApplicationController
  def search
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = "BoZy9JMdGKTMPxlogj8g0Hs11"
      config.consumer_secret      = "fwCpsL3tKcQuXG2VbqiAPqzrGLLo5WWzOZ9t6w1DH0rEZKUFZN"
    end
    @tweets = []
    since_id = nil
    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
      # 取得したツイートをモデルに渡す
      tweets.take(10).each do |tw|
        tweet = Tweet.new(tw.full_text)
        @tweets << tweet
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
    end
  end
  end
def search
  client = Twitter::REST::Client.new do |config|
-    config.consumer_key         = "xxxxxxxxxxxxxxxxxxxxxxx"
-    config.consumer_secret      = "yyyyyyyyyyyyyyyyyyyyyyyyyyyy"
+    config.consumer_key         = Rails.application.secrets.twitter_consumer_key
+    config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
end
end