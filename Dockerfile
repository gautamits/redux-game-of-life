FROM node as build-deps
WORKDIR /app
COPY package.json ./
RUN npm i
COPY . ./
RUN npm build

# Stage 2 - the production environment
FROM nginx:stable
COPY --from=build-deps /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf