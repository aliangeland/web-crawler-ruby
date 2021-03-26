FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y

# installing sqlite on the container
RUN apt-get install -y sqlite3 libsqlite3-dev

WORKDIR /myapp


RUN gem install bundler -v 2.0.1

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY crawler.gemspec ./crawler.gemspec
COPY . /myapp

RUN bundle install