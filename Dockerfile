FROM ruby:2.4
MAINTAINER mo@mokhan.ca

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  unzip \
  vim \
  postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm -g
RUN npm install phantomjs-prebuilt -g

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile* ./
RUN gem install bundler && bundle install --jobs 4
ADD . ./
