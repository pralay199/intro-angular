# Stage 1: Build the Angular app
FROM node:18.19 AS build

RUN npm install -g @angular/cli@8.3.29

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN ng build --configuration production

# RUN npm run build -- --configuration production
# EXPOSE 4200
# CMD ["ng", "serve", "--host", "0.0.0.0"]

# Stage 2: Serve the Angular app using Nginx
FROM nginx:alpine

COPY --from=build /app/dist/fairhouse /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

