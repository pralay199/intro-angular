FROM node:18.19 AS build

RUN npm install -g @angular/cli

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build -- --configuration production

CMD ["ng", "Serve"]

# Stage 2: Serve the Angular app using Nginx
# FROM nginx:alpine

# COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]
