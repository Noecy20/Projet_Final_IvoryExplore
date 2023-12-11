from flask import Flask,render_template, url_for

app = Flask(__name__)

#PREMIERE ROUTE ==> LA PREMIERE PAGE POUR LE USER
@app.route('/')
def index():
    return render_template("index.html")

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
    return render_template("hotel/hotel.html")
# FIN DE LA PAGE HOTEL

# DEBUT DE LA PAGE RESTAURANTS
#ROUTE ==> LA PAGE RESTAURANTS
@app.route('/Restaurant')
def restaurant():
    return render_template("restaurant/restaurant.html")
# FIN DE LA PAGE RESTAURANTS

@app.route('/carrou')
def carrou():
    return render_template("carroussel_resto.html")

if __name__ == "__main__":
    app.run(debug=True)
