# Radio: Icecast + BUTT

BUTT es un cliente de escritorio (emite desde tu PC). El servidor que lo recibe
y lo distribuye a tu web es **Icecast**, que es lo que empaqueta este Docker.

```
BUTT (tu PC) --> Icecast (Coolify) --> <audio> en tu página web
```

## 1. Desplegar en Coolify

1. Sube esta carpeta a un repo Git (GitHub/GitLab).
2. Coolify → New Resource → Public/Private Repository.
3. Build Pack: **Dockerfile** (o Docker Compose), Port: **8000**.
4. Domains: `https://radio.tudominio.com` (Coolify genera el HTTPS).
5. Environment Variables (obligatorias, cambia los valores):
   - `ICECAST_SOURCE_PASSWORD` — contraseña que usará BUTT
   - `ICECAST_ADMIN_PASSWORD` — acceso a `/admin`
   - `ICECAST_RELAY_PASSWORD`
   - `ICECAST_HOSTNAME` = `radio.tudominio.com`
   - `ICECAST_ALLOWED_ORIGIN` = `https://tupagina.com` (o `*` para pruebas)
6. Deploy. Abre `https://radio.tudominio.com` para ver el estado.

## 2. Configurar BUTT

Settings → Main → Server → Add:

| Campo              | Valor                          |
|--------------------|--------------------------------|
| Type               | Icecast                        |
| Address            | `radio.tudominio.com`          |
| Port               | `443`                          |
| Password           | tu `ICECAST_SOURCE_PASSWORD`   |
| Icecast mountpoint | `stream`                       |
| User               | `source`                       |

Activa **Use SSL/TLS** en la configuración del servidor, porque Coolify sirve
el dominio por HTTPS en el puerto 443. Luego pulsa "play" para emitir.

## 3. Conectar a tu página

```html
<audio controls src="https://radio.tudominio.com/stream"></audio>
```

Con botón propio:

```html
<button id="play">▶ Escuchar</button>
<script>
  const audio = new Audio("https://radio.tudominio.com/stream");
  document.getElementById("play").onclick = () =>
    audio.paused ? audio.play() : audio.pause();
</script>
```

Datos de "ahora suena" / oyentes (JSON):
`https://radio.tudominio.com/status-json.xsl`

> El mountpoint de la URL debe coincidir con el de BUTT.
> Usa MP3 en BUTT: es lo más compatible con navegadores.
