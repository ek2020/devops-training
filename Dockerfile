# stage 1
FROM node:10.15.2-alpine as build
LABEL maintainer "karthickelumalai.2020@gmail.com"
WORKDIR /app
COPY . .
RUN npm audit fix
RUN npm install
RUN npm run build --prod

# stage 2
FROM nginx:1.17.1-alpine
COPY --from=build /app/dist/angular-app /usr/share/nginx/html 

EXPOSE 8008