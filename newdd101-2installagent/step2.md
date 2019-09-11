1. Open the file `docker-compose.yml`{{open}} in the editor to the right. 
2. Notice that only a single Redis image is in the file, but we want to add the Datadog agent. Datadog will run as a sidecar container on our host. 
3. Copy the following text, then paste it into the file. 
   <pre class="file" data-target="clipboard">
   datadog:
    links:
     - redis # Ensures datadog container can connect to redis container
    image: datadog/agent:latest
    environment:
     - DD_API_KEY
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
     - /proc/mounts:/host/proc/mounts:ro
     - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
    </pre>
    