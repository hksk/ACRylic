FROM ruby:2.6.3-alpine
RUN apk add --update build-base git sqlite sqlite-dev gmp-dev libc-dev linux-headers libxml2-dev libxslt-dev readline-dev gcc libc-dev nodejs npm tzdata mariadb-dev
RUN npm install -g yarn
RUN mkdir -p /opt/
WORKDIR /opt/
COPY Gemfile /opt/
COPY Gemfile.lock /opt/
RUN gem install bundler
RUN bundle --version
RUN bundle install
RUN apk del build-base libc-dev linux-headers libxml2-dev libxslt-dev readline-dev gcc libc-dev 
COPY . /opt/
CMD bundle exec bin/server