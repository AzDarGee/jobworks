FROM ruby:3.0.1-alpine

RUN apk add --update --virtual \
    runtime-deps \
    build-base \
    libxml2-dev \
    libxslt-dev \
    sqlite-dev \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    linux-headers \
    readline-dev \
    postgresql-dev \
    libc-dev \
    file \
    imagemagick \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN gem install bundler
RUN yarn install
RUN bundle install

CMD bundle exec rake db:schema:load
CMD bundle exec rake db:migrate --trace

EXPOSE 3000
EXPOSE 3035

CMD sleep 3650d
#CMD bin/rails server -p 3000 -b 0.0.0.0
