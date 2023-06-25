FROM elixir:1.14

RUN apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive \
	apt-get -y --no-install-recommends install postgresql-client npm curl zsh inotify-tools
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN rm -rf /var/cache/apt/*

RUN mix local.hex --force && \
    mix archive.install hex phx_new --force && \
    mix local.rebar --force

ENV APP_HOME /code
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . /code
RUN cd /code

# CMD ["mix", "phx.server"]
CMD ["/bin/zsh"]