FROM centos:7

RUN yum install -y which
RUN gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
ENV PATH="/usr/local/rvm/gems/ruby-2.6.3/bin:/usr/local/rvm/gems/ruby-2.6.3@global/bin:/usr/local/rvm/rubies/ruby-2.6.3/bin:${PATH}"

RUN /usr/local/rvm/bin/rvm install 2.6 && /usr/local/rvm/bin/rvm use 2.6
RUN gem install slack-ruby-bot -v 0.12.0
RUN gem install async-websocket -v 0.8.0

RUN mkdir /opt/fuuka_bot
WORKDIR /opt/fuuka_bot
COPY secrets.sh ./
COPY src ./

CMD source ./secrets.sh && ruby main.rb
