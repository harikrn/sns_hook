FROM ruby:3.0.0-alpine3.13

# Copy application code
COPY . ./app

# Set working directory
WORKDIR /app

# Install dependencies
RUN apk add --update --no-cache \
  build-base \
  tzdata \
  && gem install bundler \
  && bundle install

EXPOSE 8181

# Start the application
CMD ["bundle", "exec", "thin", "-C", "config/thin.yml", "start"]
