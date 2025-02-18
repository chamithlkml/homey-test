FROM ruby:3.2.2

# Install Node.js, npm, yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs npm vim
RUN gem install bundler && gem install rails && npm install -g yarn
RUN npm install -g @vue/cli

# Install nginx
RUN apt-get install -y nginx
RUN mkdir /app
WORKDIR /app
COPY . .
# RUN cd /app && bundle install
# RUN cd /app && npm install

COPY start-app /usr/local/bin/start-app
RUN chmod +x /usr/local/bin/start-app

ENTRYPOINT [ "start-app" ]