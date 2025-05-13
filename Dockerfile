FROM node:20-slim as base



FROM base as build

WORKDIR /usr/app

COPY package.json package-lock.json .
RUN npm install
COPY . .
RUN npm run build



FROM --platform=linux/amd64 ubuntu/nginx as serve

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/app/build /usr/share/nginx/html/

EXPOSE 5174
