# stage 1
FROM node:latest as build
LABEL maintainer "karthickelumalai.2020@gmail.com"
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# stage 2
FROM nginx:alpine
COPY --from=build /app/dist/angular-app /usr/share/nginx/html 