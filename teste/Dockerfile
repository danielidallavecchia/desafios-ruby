FROM andersonpierok/ruby-2.1.2

USER root
RUN useradd -u 1000 -o -m -s /bin/bash app

WORKDIR /teste

COPY . .

RUN gem install bundler -v 1.17.3
RUN bundle install

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
