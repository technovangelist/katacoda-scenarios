automating storedog app

```
until $(curl -o /dev/null -s -I -f http://localhost:3000); do
    printf '.'
    sleep 5
done
printf '\n\nThe app is instrumented!\n\n'
```{{execute}}

`break-app`{{execute}}

---

`mkdir /app-files`{{execute}}

`git clone https://github.com/burningion/ecommerce-observability /app-files`{{execute}}

`cd /root/app-files`{{execute}}

`git checkout instrumented-fixed`{{execute}}

`docker-compose pull`{{execute}}

`export POSTGRES_USER=postgres`{{execute}}

`export POSTGRES_PASSWORD=postgres`{{execute}}

`docker-compose up -d`{{execute}}