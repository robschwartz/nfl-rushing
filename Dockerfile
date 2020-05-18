FROM ruby:2.6.1

WORKDIR /nfl-rushing

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash \
  && apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/* \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

COPY Gemfile* /nfl-rushing/

COPY package.json /nfl-rushing/

RUN bundle install 

RUN yarn install

COPY . /nfl-rushing/

EXPOSE 3000

CMD [ "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'" ]