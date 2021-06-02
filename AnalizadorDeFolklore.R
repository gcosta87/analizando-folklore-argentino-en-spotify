library("tidyverse");
library("spotifyr");
library("rjson");

# Variables globales
#config <- '';      # Configuracion levantada del JSON
#auth_code <- '';   # Token obtenido por SpotifyR

autenticacion <- function(){
    permisos = 'user-read-recently-played  user-top-read  user-read-playback-position  user-read-playback-state  user-read-currently-playing  app-remote-control  streaming  playlist-read-private  playlist-read-collaborative  user-follow-read  user-library-read  user-read-email  user-read-private'
    auth_code <<- get_spotify_authorization_code(scope = permisos);
}

# Inicializacion
inicializacion <- function(autenticacion=TRUE){
    # Se levanta la configuraicon del JSON
    config <<- fromJSON(file='config.json');
    
    Sys.setenv(SPOTIFY_CLIENT_ID = config$spotify_client$client_id);
    Sys.setenv(SPOTIFY_CLIENT_SECRET = config$spotify_client$secret_key);
    
    if(autenticacion){
        autenticacion();        
    }
}

# Calculo de Valoracion
calcularValoracion <- function(energy=0,valence=0){
    valoracion <- 0;
    
    if(energy <= 0.65){
        energy <- energy/16;
    }
    else{
        energy <- energy/8;
    }
    
    valoracion <- energy + valence;
    # Se acota a 1
    if(valoracion > 1){
        valoracion <- 1;
    }
    
    return(valoracion);
}

# Analisis de playlist asociada al usuario definido en «config.json»
analizarMiPlaylist <- function(playlist_name = '', min_results = FALSE, calcular_valoracion = TRUE){
    playlist <- get_my_playlists(authorization = auth_code, limit = 50) %>% filter(owner.id == config$user_name, name == playlist_name) %>% select(id, name);
    
    # Caracteristicas de los temas
    tracks  <-  get_playlist_tracks(playlist$id,limit = 100);
    tracks_ids <- tracks %>% pull(var = 'track.id') 
    tracks_features <- get_track_audio_features(ids=tracks_ids);
    
    
    # Se joinea la info de los tracks (tracks) con las caracteristicas para obtener toda la info
    tracks_info_features <-
        tracks %>%
        select(track.id, added_at, track.name, track.popularity) %>%
        rename(name = track.name, popularity = track.popularity) %>%
        inner_join(tracks_features, by= c('track.id' = 'id'));
    
    
    # Se dejan solo las "columnas" mas importantes
    if(min_results){
        # tracks_info_features <- tracks_info_features %>% select(track.name, track.popularity, danceability, energy, valence,tempo,duration_ms)
        tracks_info_features <- tracks_info_features %>% select(name, popularity, danceability, energy, valence,tempo,duration_ms)
        
    }
    
    if(calcular_valoracion){
        calcularValoracionVectorized <- Vectorize(calcularValoracion);
        tracks_info_features <- tracks_info_features %>% mutate(valoracion = calcularValoracionVectorized(energy,valence))
    }
    
    return(tracks_info_features);
}
