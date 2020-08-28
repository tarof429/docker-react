# First stage: build the project
FROM node:alpine AS node_builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Second stage: build the production image
FROM nginx:alpine
EXPOSE 80
WORKDIR /usr/share/nginx/html
COPY --from=node_builder /app/build .
