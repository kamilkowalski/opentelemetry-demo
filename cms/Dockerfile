FROM elixir:alpine

# install build dependencies
RUN apk add --no-cache build-base npm git

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

# We need to copy lib so Tailwind's purge works well
COPY lib lib
COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
RUN mix do compile, release

RUN chown -R nobody:nobody /app/_build/prod/rel/cms
USER nobody:nobody
WORKDIR /app/_build/prod/rel/cms

CMD bin/cms eval "Cms.Release.setup()" && bin/cms start
