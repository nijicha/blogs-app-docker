# set the base image to ruby
FROM ruby:2.7.2

# NOTE: Enable for install Rails + Webpacker
# Set ENV
# ENV NVM_VERSION v0.37.0
# ENV NODE_VERSION v14.15.0
# ENV NVM_DIR /usr/local/nvm

# ENV NODE_PATH $NVM_DIR/$NODE_VERSION/lib/node_modules
# ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

# Register repository for yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl postgresql-client \
    # && apt-get install --no-install-recommends yarn \
    && apt-get -y autoclean

# Install nvm
# RUN mkdir $NVM_DIR
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

# Install node.js and set default to nvm
# RUN echo "source $NVM_DIR/nvm.sh && \
#     nvm install $NODE_VERSION && \
#     nvm alias default $NODE_VERSION && \
#     nvm use default" | bash

# RUN node -v
# RUN npm -v
# RUN npx -v
# RUN yarn -v

# parse rails app to /myapp
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
