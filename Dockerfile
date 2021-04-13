FROM homebrew/brew:latest

ADD ./Formula/moreutils.rb /moreutils.rb

WORKDIR /

ENV HOMEBREW_NO_AUTO_UPDATE 1

RUN brew install ./moreutils.rb
