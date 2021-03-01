FROM ruby:2.7.1

ENV LANG C.UTF-8
RUN gem install bundler

ENV APP_HOME /free-note-api

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY  . $APP_HOME

ARG RAILS_ENV="develop"
ENV RAILS_ENV ${RAILS_ENV}

RUN bundle install --jobs=10
RUN mkdir -p tmp/pids

CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
