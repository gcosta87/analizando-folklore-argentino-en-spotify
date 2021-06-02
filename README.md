# analizando-folklore-argentino-en-spotify
Este repositorio intentará almacenar algunas pruebas de la API Spotify aplicadas al Folklore Argentino, utilizando R!.

## AnalizadorDeFolklore.R
Es un "pseudo-wrapper" de la API Spotify para R ([SpotifyR](https://github.com/charlie86/spotifyr/issues)), que a partir de una configuración dada en el config.json, levanta una instancia lista para realizar consultas.

```json
{
    "user_name": "mi_usuario",
    
    "spotify_client":{
        "client_id":  "0d6f6f8ce48d4bbf9109a0210e24ad24",
        "secret_key": ""
    }
    
}
```

Se intentará implementar funciones utiles y "comunes" en el analisis de canciones, playlist y/o artistas.

## analizarMiPlaylist.R

Pequeño ejemplo del uso del AnalizadorDeFolklore, para procesar las 100 primeras canciones de una playlist propia:

```
                                                     name popularity danceability energy valence   tempo duration_ms valoracion
1   Todos a bailar - Feat. Los Carabajal & Leandro Lovato         19        0.480  0.723   0.733  80.840      140243  0.8233750
2                                         La del Carnaval          4        0.378  0.653   0.786 184.661      199211  0.8676250
3                                       La Noche de Salta         27        0.634  0.798   0.650  80.252      142985  0.7497500
4                                       Gato del Festival         32        0.563  0.963   0.760 170.621      113293  0.8803750
5                                   Zamba de la Bailarina         40        0.575  0.672   0.548 108.177      176493  0.6320000
6                                             La Revancha         15        0.504  0.720   0.388 160.733      148774  0.4780000
```

