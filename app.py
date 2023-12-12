from flask import Flask,render_template, url_for, request, redirect, flash
import pyodbc

import pandas as pd

app = Flask(__name__)

app.config['SECRET_KEY'] = 'clés_flash'

app.config['SQL_SERVER_CONNECTION_STRING'] = r"""
    Driver={SQL Server};
    Server=DESKTOP-DLHA7UR\SQLEXPRESS;
    Database=ivory;
    Trusted_Connection=yes;"""

conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])


def index(request, df_knn_final_X=None, df=None):
    # Load the main database
    df_full_final_X = pd.read_csv('https://media.githubusercontent.com/Media/Dinoxel/film_reco_app/master/Desktop/projets/projet_2/database_imdb/df_full_final_X.csv', index_col=0)

    # Store the display database
    df_display_final_def = df_full_final_X.copy()[['titleId', 'title', 'multigenres', 'startYear', 'runtimeMinutes', 'averageRating', 'numVotes', 'nconst']]
    df_display_final_def['nconst'] = df_display_final_def['nconst'].astype(str)

    # Store the knn database
    df_knn_final_def = df_full_final_X.copy().drop(columns=['averageRating', 'numVotes', 'startYear', 'runtimeMinutes', 'multigenres', 'years', 'nconst'])

    # Select all boolean columns
    X = df_knn_final_X.iloc[:, 2:].columns

    # Set the base weight for all columns to 1
    df_weights = pd.DataFrame([[1 for x in X]], columns=X)

    # Set the weights for each part
    weight_genres = 0.65
    weight_rating_low = 0.75
    weight_reals = 1.25
    weight_actors = 0.5
    weight_years = 0.85
    weight_years_low = 0.75
    weight_numvotes_low = 0.5
    weight_numvotes_med = 0.65

    df_genres = df
#PREMIERE ROUTE ==> LA PREMIERE PAGE POUR LE USER
@app.route('/')
def index():
    return render_template("index.html")

# DEBUT DE LA PAGE dasbord
# ROUTE ==> LA PAGE dasbord
@app.route('/dashbord')
def dash():
    return render_template("dashbord.html")
#LA PAGE INSCRIPTION
# DEBUT DE LA PAGE INSCRIPTION
# ROUTE ==> LA PAGE INSCRIPTION
@app.route('/Inscription')
def inscription():
    return render_template("user_connect/inscription.html")
#LA PAGE INSCRIPTION

# DEBUT DE LA PAGE CONNEXION
#ROUTE ==> LA PAGE CONNEXION
@app.route('/Connexion')
def connexion():
    return render_template("user_connect/connexion.html")
# FIN DE LA PAGE CONNEXION

# DEBUT DE LA PAGE PREFERENCE
#ROUTE ==> LA PAGE PREFERENCE
@app.route('/Préférences')
def preference():
    return render_template("user_connect/preference.html")
# FIN DE LA PAGE PREFERENCE

# DEBUT DE LA PAGE ACCCUEIL
#ROUTE ==> LA PAGE ACCUEIL
@app.route('/Accueil')
def accueil():
    return render_template("accueil.html")
# FIN DE LA PAGE ACCCUEIL

# DEBUT DE LA PAGE ECOLE
#ROUTE ==> LA PAGE ECOLE
@app.route('/Ecole')
def ecole():
    return render_template("ecole/ecole.html")
# FIN DE LA PAGE ECOLE


# DEBUT DE LA PAGE FILM
#ROUTE ==> LA PAGE FILM
@app.route('/Film')
def film():
    return render_template("film/film.html")
# FIN DE LA PAGE FILM

# DEBUT DE LA PAGE HOTEL
#ROUTE ==> LA PAGE HOTEL
@app.route('/Hotel')
def hotel():
    conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
    cursor = conn.cursor()
    cursor.execute(" select * from hotel")
    data = cursor.fetchall()
    # connexion.close()
    return render_template("hotel/hotel.html",data=data)
# FIN DE LA PAGE HOTEL

# DEBUT DE LA PAGE RESTAURANTS
#ROUTE ==> LA PAGE RESTAURANTS
@app.route('/Restaurant')
def restaurant():
    conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
    cursor = conn.cursor()
    cursor.execute(" select * from restaurant")
    data = cursor.fetchall()
    
    return render_template("restaurant/restaurant.html",data=data)

# FIN DE LA PAGE RESTAURANTS

@app.route('/carrou')
def carrou():
    return render_template("carroussel_resto.html")

if __name__ == "__main__":
    app.run(debug=True)
