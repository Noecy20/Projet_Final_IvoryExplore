<<<<<<< HEAD
from flask import Flask,render_template, url_for, request, redirect, flash,session
=======
from flask import Flask,render_template, url_for, request, redirect, flash, session
>>>>>>> 43427bef11a6c025e19b5f649395221ef963ab2a
import pyodbc
import re
import bcrypt
from werkzeug.security import generate_password_hash, check_password_hash
import pandas as pd

app = Flask(__name__)

app.config['SECRET_KEY'] = 'clés_flash'

app.config['SQL_SERVER_CONNECTION_STRING'] = """
    Driver={SQL Server};
<<<<<<< HEAD
    Server=MTN-Academy\SQLEXPRESS;
    Database=ivory;
=======
    Server=DESKTOP-DLHA7UR\\SQLEXPRESS;
    Database=IvoryExplore;
>>>>>>> 43427bef11a6c025e19b5f649395221ef963ab2a
    Trusted_Connection=yes;"""

conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])


#PREMIERE ROUTE ==> LA PREMIERE PAGE POUR LE USER
@app.route('/')
def index():
    
    return render_template("index.html")

# DEBUT DE LA PAGE dasbord
# ROUTE ==> LA PAGE dasbord
<<<<<<< HEAD
# @app.route('/dashbord')
# def dash():
#     return render_template("dashbord.html")
=======
@app.route('/dashbord')
def dash():
    return render_template("dashbord.html")

>>>>>>> 43427bef11a6c025e19b5f649395221ef963ab2a
#LA PAGE INSCRIPTION
# DEBUT DE LA PAGE INSCRIPTION
# ROUTE ==> LA PAGE INSCRIPTION
@app.route('/Inscription',methods=["GET", "POST"])
def inscription():
    if request.method == 'POST':
        nom_user = request.form["nom_user"]
        prenom_user = request.form["prenom_user"]
        username = request.form["username"]
        email = request.form["email"]
        passwords = request.form["passwords"]
        hashed_password = generate_password_hash(passwords)

        conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE username = ? OR email = ?', (username, email))
        users = cursor.fetchall()

        if users:
            flash("ce compte existe déjà !", 'info')
        elif not re.match(r'[a-zA-Z0-9]+$', username):
            flash("Le nom d'utilisateur ne doit contenir que des lettres et des chiffres !", 'info')
            return redirect(url_for('inscription'))
        elif not re.match(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
            flash("Email Invalid !", 'info')
            return redirect(url_for('inscription'))

        else:
            conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
            cursor = conn.cursor()
            cursor.execute('''
                INSERT INTO users (nom_user,prenom_user, username, email, Passwords)
                VALUES ( ?, ?, ?, ?, ?)
             ''', (nom_user,prenom_user,username, email, hashed_password))
            conn.commit()
            conn.close()
            flash("Votre compte a été enregistré avec succès !", 'info')
            return redirect(url_for('preference'))

    return render_template("user_connect/inscription.html")
#LA PAGE INSCRIPTION

# DEBUT DE LA PAGE CONNEXION
#ROUTE ==> LA PAGE CONNEXION
@app.route('/Connexion',methods=["GET", "POST"])
def connexion():
<<<<<<< HEAD
    conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
    cursor = conn.cursor()
    # cursor.execute("SELECT * FROM users where email=?",(email,))
    # user = cursor.fetchone()
    # session["user"]=user
=======
    if request.method == 'POST':
        email = request.form["email"]
        passwords = request.form["passwords"]
        conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE email = ?', (email))
        users = cursor.fetchone()
        if users:
            user_pswd = users[5]
            if check_password_hash(user_pswd, passwords):
                session['loggedin'] = True
                session['Id'] = users[0]
                session['username'] = users[1]
                return redirect(url_for('accueil'))
            else:
                flash("Mot de passe incorrect !", 'info')
                return redirect(url_for('connexion'))
        else:
            flash("Identifiant incorrect !", 'info')
            return redirect(url_for('connexion'))

>>>>>>> 43427bef11a6c025e19b5f649395221ef963ab2a
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
    if 'loggedin' in session:
        conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
        cursor = conn.cursor()
        cursor.execute(" select * from restaurant")
        data = cursor.fetchall()
        return render_template("restaurant/restaurant.html",data=data)
    return redirect(url_for('connexion'))
# FIN DE LA PAGE RESTAURANTS



#dashoard
@app.route('/dashbord',methods = ['POST', 'GET'])
def dashbord():
    if(session['users'][4]!="admin"):
        return redirect(request.referrer)
    else:
        conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
        cursor = conn.cursor()
        cursor.execute("select * from users")
        # cursor.execute(""" SELECT * FROM Transfert """)
        data = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template("dashbord.html" , data1=data)


if __name__ == "__main__":
    app.run(debug=True)
