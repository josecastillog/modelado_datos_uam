###############################################################
#
# MODELADO, ALMACENAMIENTO Y GESTIÓN DE DATOS (Grupo 726)
#
# Practica: 1
# Fichero: genres.py
# Autores: 
# José Manuel Castillo Guajardo
# Nora Lizeth Villarreal Guerra
# Fecha: 3 de octubre de 2023
#
# Conversión genres a csv
#
###############################################################

import pandas as pd
import json

# Función para convertir json a dict
# También corrige formato de usar comilla doble en lugar de sencilla
# '' -> ""
def correct_json_format(json_str):
    try:
        # Replace single quotes with double quotes
        json_str = json_str.replace("'", "\"")
        # Parse the corrected JSON string
        data = json.loads(json_str)
        return data
    except (ValueError, json.JSONDecodeError):
        return None

# Leer el fichero
df = pd.read_csv('archive/movies_metadata.csv')

# Convertir de json de string a diccionario
df['genres'] = df['genres'].apply(correct_json_format)

# Crear lista de dataframes de json en cada fila
genre_dfs = [pd.DataFrame(genres) for genres in df['genres']]

# Concatenar la lista de dataframes en uno mismo
genres_df = pd.concat(genre_dfs, ignore_index=True)

# Descartar duplicados en dataframe
unique_genres_df = genres_df.drop_duplicates(subset='id').reset_index(drop=True)

# Imprimir dataframe final (primeros 10 datos)
print(unique_genres_df)
unique_genres_df.to_csv('genres.csv', index=False)