# Use the official Ruby image as a base image
FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ROOT /app
ENV LANG C.UTF-8

# Create and set the working directory
WORKDIR $RAILS_ROOT

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev nodejs

# Copy Gemfile and Gemfile.lock and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the rest of the application code
COPY . .

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
