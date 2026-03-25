# Etapa 1: Construcción
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
# Copiamos el wrapper de Gradle y la carpeta con su configuración
COPY gradlew .
COPY gradle ./gradle
# Copiamos los archivos de configuración de dependencias
COPY build.gradle settings.gradle ./
# Copiamos el código fuente
COPY src ./src
# Damos permisos de ejecución al script del wrapper y construimos
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

# Etapa 2: Ejecución (usa JRE en lugar de JDK para seguridad)
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Crear usuario no-root para seguridad
RUN useradd -m -u 1000 appuser
# Copiamos el JAR generado
COPY --from=build /app/build/libs/*-SNAPSHOT.jar app.jar
# Cambiar propietario
RUN chown appuser:appuser app.jar
USER appuser
# Puerto de Spring Boot
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]