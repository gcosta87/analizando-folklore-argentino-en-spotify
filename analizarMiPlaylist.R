# Se inicializa segun la configuracion dada...
inicializacion();
resultados <- analizarMiPlaylist('Folklore Argentino con todo! 🇦🇷',min_results = TRUE);
resultados;

# Exportacion a CSV
write.csv(x = resultados,file = "~/Escritorio/playlist_analisis.csv")

