# Etapa 1: Construcción con Node
FROM node:20-alpine AS build
WORKDIR /app
# Copiamos solo los archivos de dependencias primero (optimiza el caché de Docker)
COPY package*.json ./
RUN npm install
# Copiamos el resto del código y construimos
COPY . .
RUN npm run build

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine
# Vite guarda los archivos compilados en la carpeta 'dist' (no en 'build')
COPY --from=build /app/dist /usr/share/nginx/html
# Exponemos el puerto 80 (el estándar de la web)
EXPOSE 80
# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]