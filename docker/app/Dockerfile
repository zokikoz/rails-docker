FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y build-essential nodejs curl libpq-dev

# Yarn
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV='production'
ENV RACK_ENV='production'

# Adding gems
COPY app/Gemfile Gemfile
COPY app/Gemfile.lock Gemfile.lock

RUN bundle config set --local without 'development test'
RUN bundle install --jobs 20 --retry 5

# Adding project files
COPY app .

RUN bundle exec rake assets:precompile

# Add start script (server.pid check)
COPY docker/app/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
