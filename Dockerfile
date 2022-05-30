# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN apt-get update -qq \
 && apt-get install -y nodejs postgresql-client npm \
 && rm -rf /var/lib/apt/lists/* \
 && npm install --global yarn
WORKDIR /rails7_spa
COPY Gemfile /rails7_spa/Gemfile
COPY Gemfile.lock /rails7_spa/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 4000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
