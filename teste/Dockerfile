FROM andersonpierok/ruby-2.1.2

WORKDIR /teste

COPY . .

RUN gem install bundler -v 1.17.3
RUN bundle install

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
