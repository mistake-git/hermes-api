FROM ruby:3.2.2

# nginxのインストール
RUN apt-get update

# Railsアプリケーションのディレクトリを設定
RUN mkdir /job-hunting-api
WORKDIR /job-hunting-api

# GemfileとGemfile.lockをコピーして依存関係をインストール
COPY Gemfile /job-hunting-api/Gemfile
COPY Gemfile.lock /job-hunting-api/Gemfile.lock
RUN bundle install

# Railsアプリケーションのコードをコピー
COPY . /job-hunting-api

# エントリーポイントスクリプトを設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Railsアプリケーション用のポート3000を公開
EXPOSE 3000

# nginxとRailsサーバーを起動
CMD service nginx start && bundle exec rails server -b 0.0.0.0
