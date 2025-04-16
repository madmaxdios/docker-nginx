# Example nginx docker

## Create .env file

- Open [.env.example](.env.example) and save as `.env`

## dev

`npm run dev`

## Docker Build Start Local para pruebas

- `docker compose --profile development up --build -d` TODO posible solución

## Docker Build Start Server

- `docker compose --profile production up --build -d` TODO posible solución

## Condiciones

- Se necesita configuración de un proyecto "hola mundo" de nextjs, con docker-compose:

- Docker

  1. Configuración para poder probar `npm run start` con docker con https en local.
  2. Configuración para poder ejecutar en staging, test, production

- Nginx

  1. Logrotate para que cada día haga un nuevo log.
  2. Formato log sea lo más compacto posible y que ocupe lo menos posible, se deja fichero [log_format.conf](nginx/conf/log_format.conf).
  3. En caso de página caída con error 50x que muestre [50x.html](nginx/html/50x.html)
  4. Adjuntar información sobre geolocalización de las peticiones a dicho log.
  5. Autoborrado de ficheros de logs de mas de **120** días.
  6. Usar https con `nginxproxy/nginx-proxy` y `nginxproxy/acme-companion`

- Elasticsearch:
  1. Que recoja los ficheros de logs de nginx, en /logs/nginx.
  2. Que recoja los ficheros de logs de nextjs, en /logs/nextjs.

- Cualquier mejora será bien recibida.
