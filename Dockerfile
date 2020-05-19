FROM ruby:2.6.1

RUN mkdir /nfl-rushing
WORKDIR /nfl-rushing

# Install Node.js
RUN apt-get update \
  && apt-get install -y apt-utils build-essential libpq-dev curl \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && echo "Installing Node.js -v 10.x" \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN export DEBIAN_FRONTEND=noninteractive \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

# Install app dependencies
COPY Gemfile* /nfl-rushing/
COPY package.json /nfl-rushing/

RUN bundle install 
RUN yarn install

# Bundle app source
COPY . /nfl-rushing/

EXPOSE 3000

CMD [ "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'" ]