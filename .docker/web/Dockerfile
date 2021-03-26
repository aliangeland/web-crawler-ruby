# FROM ruby:2.5

# RUN mkdir /app
# WORKDIR /app

# RUN gem install bundler -v 2.0.1

# COPY Gemfile ./Gemfile
# COPY Gemfile.lock ./Gemfile.lock
# COPY crawler.gemspec ./crawler.gemspec
# COPY lib ./lib
# COPY spec ./spec
# COPY examples ./examples
# RUN bundle install -j 20

# CMD ["./examples/crawler.rb"]


# FROM alpine:3.2
# ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
# ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler
# # Update and install all of the required packages.
# # At the end, remove the apk cache
# RUN apk update && \
#     apk upgrade && \
#     apk add $BUILD_PACKAGES && \
#     apk add $RUBY_PACKAGES && \
#     rm -rf /var/cache/apk/*
# RUN mkdir /usr/app
# WORKDIR /usr/app
# COPY Gemfile /usr/app/
# COPY Gemfile.lock /usr/app/
# RUN bundle install
# COPY . /usr/app




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




# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000


# CMD ["rails", "server", "-b", "0.0.0.0"]