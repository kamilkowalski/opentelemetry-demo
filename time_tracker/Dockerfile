FROM node:alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --progress=false --no-audit --loglevel=error

COPY . .

CMD npm start
