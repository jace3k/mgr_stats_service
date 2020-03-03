FROM ruby:2.6.3 as stats-service


ARG proxy
ENV http_proxy=$proxy https_proxy=$proxy

RUN mkdir /app
WORKDIR /app

COPY . .

ENV rails=/app/bin/rails
ENV bundle=/app/bin/bundle

RUN apt-get update -y
RUN gem install bundler:2.1.3
RUN $bundle

EXPOSE 3000

CMD rm -f /app/tmp/pids/server.pid && \
    $rails db:migrate && \
    $rails s -b 0.0.0.0 -p 3000
