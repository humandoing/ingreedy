
# Use an official Ruby runtime as a parent image
FROM ruby:3.1.4

# Set the working directory in the container
WORKDIR /code

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* /code

RUN gem install solargraph
RUN gem install rubocop

# Install any needed gems specified in Gemfile
# This is done before adding the entire project to make use of cached Docker layers
#RUN bundle install

# You don't need to copy your project files here because we'll use a volume to sync them

# The CMD command can be overwritten in docker-compose.yml if needed
#CMD ["bash"]