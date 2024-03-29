from flask import Flask, render_template, url_for, request, redirect, flash, session
import pyodbc
import re
from werkzeug.security import generate_password_hash, check_password_hash
import folium 
from folium.plugins import MarkerCluster
import pandas as pd
import random
import os
import bcrypt
from werkzeug.utils import secure_filename
import time
# from flask_mail import Mail, Message
# import secrets  # Pour générer des tokens sécurisés

app = Flask(__name__)

    # Initialisation de l'extension Flask-WTF


app.config['SECRET_KEY'] ='clés_flash'
# DRIVER_NAME = 'SQL SERVER'
# SERVER_NAME = 'DESKTOP-02KB7J2'
# DATABASE_NAME = 'ivoryExplore'

# app.config['SQL_SERVER_CONNECTION_STRING'] = """
#     Driver={SQL Server};
#     Server=Geek_Machine\SQLEXPRESS;
#     Database=IvoryExplore;
#     Trusted_Connection=yes;"""
connection_string = (
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=MTN-Academy\SQLEXPRESS;"
    "Database=Script_ivory;"
    "Trusted_Connection=yes"
)



######## PROFIL UTILISATEUR ############## 

## Mise à jour photo de profil ##

UPLOAD_FOLDER_PARENT = 'static/uploads/images_profil_parent'
app.config['UPLOAD_FOLDER_PARENT'] = UPLOAD_FOLDER_PARENT
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['SESSION_TYPE'] = 'filesystem'

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/upload_profile', methods=['POST'])
def upload_profile():
    if 'profileImage' not in request.files:
        return 'Aucun fichier trouvé'

    file = request.files['profileImage']

    if file.filename == '':
        return 'Aucun fichier sélectionné'

    if file and allowed_file(file.filename):
        if not os.path.exists(UPLOAD_FOLDER_PARENT):
            os.makedirs(UPLOAD_FOLDER_PARENT)

        # Générez un nom de fichier unique en ajoutant un timestamp
        timestamp = int(time.time())
        filename = secure_filename(file.filename)
        unique_filename = f"{filename}_{timestamp}"

        file_path = os.path.join(app.config['UPLOAD_FOLDER_PARENT'], unique_filename)
        file.save(file_path)

        relative_path = os.path.relpath(file_path, app.config['UPLOAD_FOLDER_PARENT'])

        user_id = session.get('Id')

        if user_id is not None:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            cursor.execute("UPDATE users SET profileImage = ? WHERE id = ?", (relative_path, user_id))
            conn.commit()
            flash('Profil mis à jour avec succès!', 'success')
            return 'Succès'
        else:
            return 'Erreur id de l\'utilisateur'

    return 'Erreur lors du téléchargement du fichier'
## Fin Mise à jour photo de profil ##

## Modification du compte ##

@app.route("/Modif_compte", methods=["GET", "POST"])
def Modif_compte():
    if request.method == "GET":
        # Récupérer l'ID de l'utilisateur connecté (assurez-vous d'avoir une session utilisateur)
        user_id = session.get('Id')  # Implémentez la fonction get_user_id selon votre logique d'authentification

        # Exécuter une requête SQL pour récupérer les données de l'utilisateur
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users WHERE id = ?", user_id)
        user_data = cursor.fetchone()

        # Passer les données à la page HTML
        return render_template("user_connect/modif_compte.html", user_data=user_data)
    
    elif request.method == "POST":
        # Récupérer les données du formulaire
        user_id = request.form.get("id")
        prenom = request.form.get("prenom")
        nom = request.form.get("nom")
        email = request.form.get("mail")
        username = request.form.get("username")

        # Exécuter une requête SQL pour mettre à jour les données de l'utilisateur
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("UPDATE users SET prenom_user=?, nom_user=?, email=?, username=? WHERE id=?", 
                       prenom, nom, email, username, user_id)
        
        # Valider la transaction et fermer la connexion
        conn.commit()
        conn.close()

        # Rediriger vers la page d'accueil ou une autre page de confirmation
        return redirect(url_for("accueil"))


@app.route("/Modif_mot_de_passe", methods=["POST"])
def Modif_mot_de_passe():
    # Récupérer l'ID de l'utilisateur connecté (assurez-vous d'avoir une session utilisateur)
    user_id = session.get('Id')  # Implémentez la fonction get_user_id selon votre logique d'authentification

<<<<<<< HEAD
=======
    # Récupérer les données du formulaire
    old_password = request.form.get("mdp")
    new_password = request.form.get("new")
    confirm_password = request.form.get("confirm")

    # Exécuter une requête SQL pour récupérer le mot de passe actuel de l'utilisateur
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute("SELECT passwords FROM users WHERE id = ?", user_id)
    current_password = cursor.fetchone()[0]

    # Vérifier si l'ancien mot de passe saisi correspond au mot de passe actuel
    if not check_password_hash(current_password, old_password):
        flash("L'ancien mot de passe est incorrect", "error")
        return redirect(url_for("Modif_compte"))

    # Vérifier si les nouveaux mots de passe correspondent
    if new_password != confirm_password:
        flash("Les nouveaux mots de passe ne correspondent pas", "error")
        return redirect(url_for("Modif_compte"))
>>>>>>> 6483aff29220a07e934b2192a7b8b9fc5e5d4a41



    # Hasher le nouveau mot de passe
    hashed_password = generate_password_hash(new_password)

    # Exécuter une requête SQL pour mettre à jour le mot de passe de l'utilisateur
    cursor.execute("UPDATE users SET passwords = ? WHERE id = ?", hashed_password, user_id)

    # Valider la transaction et fermer la connexion
    conn.commit()
    conn.close()

    flash("Mot de passe mis à jour avec succès", "success")
    return redirect(url_for("Modif_compte"))

 ## Fin Modification du compte ##

## Debut suppression du compte ##
@app.route("/sup_compte", methods=["GET", "POST"])
def sup_compte():
    if request.method == "GET":
        # Vérifiez si l'utilisateur est connecté
        user_id = session.get('Id')  # Remplacez 'Id' par la clé appropriée utilisée dans votre session

        if user_id is None:
            # Rediriger l'utilisateur vers la page de connexion s'il n'est pas connecté
            return redirect(url_for("login"))

        # Exécuter une requête SQL pour récupérer les données de l'utilisateur
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users WHERE id = ?", user_id)
        user_data = cursor.fetchone()

        # Fermer la connexion
        conn.close()

        # Afficher la page de suppression de compte avec les données de l'utilisateur
        return render_template("user_connect/sup_compte.html", user_data=user_data)

    elif request.method == "POST":
        # Récupérer l'ID de l'utilisateur connecté
        user_id = session.get('Id')  # Remplacez 'Id' par la clé appropriée utilisée dans votre session

        # Exécuter une requête SQL pour supprimer le compte de l'utilisateur
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("DELETE FROM users WHERE id = ?", user_id)

        # Valider la transaction et fermer la connexion
        conn.commit()
        conn.close()

        # Déconnecter l'utilisateur (effacer la session)
        session.clear()

        # Afficher un message de confirmation
        flash("Votre compte a été supprimé avec succès.", "success")

        # Rediriger l'utilisateur vers une page de confirmation ou d'accueil
        return redirect(url_for("accueil"))

## Fin suppression du compte ##

######## FIN PROFIL UTILISATEUR ############## 


#PREMIERE ROUTE ==> LA PREMIERE PAGE ACCUEIL POUR TOUT LE MONDE
@app.route('/')
def index():
    return render_template("index.html")

# DEBUT DE LA PAGE dasbord
# ROUTE ==> LA PAGE dasbord
@app.route('/dashbord', methods = ['POST', 'GET'])
def dash():
#  if 'loggedin' in session:
#     # if session['role'] != 'admin':
#     #     return redirect(request.referrer)
#     # else:
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute("select  * from users")
    # cursor.execute(""" SELECT * FROM Transfert """)
    data = cursor.fetchall()
    nbr_user=len(data)
    conn.commit()
    conn.close()
    flash("votre utilisateur à été supprimé", 'succès')

    return render_template("dashbord.html", data1=data , nbr_user=nbr_user)
# return redirect(url_for('connexion'))



# formulaire de modification du dashboard

@app.route("/form_modif_dash.html/<int:prod>", methods=['POST', 'GET'])
def form_modif_dash(prod ):

    if request.method == 'POST':
            Nom = request.form['nom_user']
            Prenoms = request.form['prenom_user']
            Username = request.form['username']
            Email = request.form['email']
            conn = pyodbc.connect(connection_string)
            cur = conn.cursor()
            cur.execute('''
                        update users set nom_user=?, prenom_user=?, username=?, email=? where id=?''',
                        (Nom, Prenoms, Username, Email, prod ))
            conn.commit()
            conn.close()
            flash('utilisateur  modifié','succès')
            return redirect(url_for("dash"))
    prod = int(prod)
    conn = pyodbc.connect(connection_string)
    cur = conn.cursor()
    cur.execute("select * from users where id=?", (prod,))
    base = cur.fetchone()
    return render_template("/form_modif_dash.html", mybase=base)


#partie supression utilisateur dans le dashbord
@app.route("/sup_users/<string:suppr>", methods=['POST','GET'])
def sup_users(suppr):
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute('DELETE from users where id=?', (suppr),)
    conn.commit()
    conn.close()
    flash("votre produit à été supprimé", 'succès')
    return redirect(url_for('dash'))


@app.route('/Inscription', methods=["GET", "POST"])
def inscription():
    if request.method == 'POST':
        nom_user = request.form["nom_user"]
        prenom_user = request.form["prenom_user"]
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["passwords"]
        confirm_password = request.form["confirm_password"]  # Ajout du champ de confirmation de mot de passe
        hashed_password = generate_password_hash(password)
        
        # Vérification que le mot de passe et la confirmation de mot de passe sont identiques
        if password != confirm_password:
            flash("Les mots de passe ne sont pas identique !", 'info')
            return redirect(url_for('inscription'))

        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE username = ? OR email = ?', (username, email))
        users = cursor.fetchall()

        if users:
            flash("Ce compte existe déjà !", 'info')
        elif not re.match(r'[a-zA-Z0-9]+$', username):
            flash("Le nom d'utilisateur ne doit contenir que des lettres et des chiffres !", 'info')
            return redirect(url_for('inscription'))
        elif not re.match(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
            flash("Email invalide !", 'info')
            return redirect(url_for('inscription'))
        else:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            c = cursor.execute('''
                INSERT INTO users (nom_user, prenom_user, username, email, passwords)
                VALUES (?, ?, ?, ?, ?)
            ''', (nom_user, prenom_user, username, email, hashed_password))
            
            cursor.execute('''
                SELECT id FROM users WHERE email = ? AND username = ?
            ''', (email, username))
                
            user_id = cursor.fetchone().id

            cursor.execute('''
                INSERT INTO nco (id_user, nombre_connexion)
                VALUES (?, ?)
            ''', (user_id, 0))
            
            conn.commit()
            conn.close()
            
            flash("Votre compte a été enregistré avec succès !", 'info')
            return redirect(url_for('connexion'))

    return render_template("user_connect/inscription.html")

#LA PAGE INSCRIPTION

# DEBUT DE LA PAGE CONNEXION
#ROUTE ==> LA PAGE CONNEXION

@app.route('/Connexion',methods=["GET", "POST"])
def connexion():
    if request.method == 'POST':
        email = request.form["email"]  # Utilisateur peut saisir l'e-mail ou le nom d'utilisateur
        passwords = request.form["passwords"]
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE email = ? OR username = ?', (email, email))
        users = cursor.fetchone()
        if users:
            user_pswd = users[5]

            if check_password_hash(user_pswd, passwords):

                session['loggedin'] = True
                session['Id'] = users[0]
                session['username'] = users[1]

              # Utilisation du contexte 'with' pour la requête SELECT
                with cursor.execute('SELECT * FROM nco WHERE id_user = ?', (session['Id'])) as result:
                    test = result.fetchone()

                compte = test.nombre_connexion + 1
                cursor.execute('UPDATE nco SET nombre_connexion = ? WHERE id_user = ?', (compte, session['Id']))
                conn.commit()
                conn.close()

                if compte == 1:
                    return redirect(url_for('preference'))
                else:
                    return redirect(url_for('accueil'))
            else:
                flash("Mot de passe incorrect !", 'info')
                return redirect(url_for('connexion'))
        else:
          flash("Identifiant incorrect !", 'info')
          return redirect(url_for('connexion'))
    
    return render_template("user_connect/connexion.html")
# FIN DE LA PAGE CONNEXION

#DEBUT MOT DE PASSE OUBLIE ET RECUPERATION
# Route du mot de passe oublié

@app.route('/mot_de_passe_oublie')
def mot_de_passe_oublie():
    return render_template('user_connect/mot_de_passe_oublie.html')

@app.route('/mot_de_passe_oublie_traitement', methods=['POST'])
def mot_de_passe_oublie_traitement():
    if request.method == 'POST':
        email = request.form['Email']
        
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM users WHERE email = ?", (email,))
        
        # Récupérer les résultats de la requête
        result = cursor.fetchone()

        cursor.close()

        if result:
#             # Si l'e-mail existe, rediriger vers la page de réinitialisation avec l'ID associé
            # flash('E-mail trouvé. Redirection vers la page "/grace".')
            return redirect(url_for('réinitialiser', user_id=result[0]))
        else:
            # Si l'e-mail n'existe pas, afficher un message d'erreur
            flash('E-mail non trouvé. Veuillez réessayer.', 'danger')
            return redirect(url_for('mot_de_passe_oublie'))  # Assurez-vous d'ajuster la route de redirection

    # Si la requête n'est pas POST ou si l'e-mail n'existe pas, rester sur la même page
    return render_template("user_connect/mot_de_passe_oublie.html")  # Assurez-vous d'ajuster le nom du template

@app.route('/réinitialiser/<int:user_id>')
def réinitialiser(user_id):
    # Traitez l'ID de l'utilisateur comme nécessaire dans cette route
    return render_template('user_connect/réinitialiser.html', user_id=user_id)

@app.route("/réinitialiser_traitement/<int:user_id>",  methods=["GET", "POST"])
def réinitialiser_traitement(user_id):
    if request.method == 'POST':
        mot_de_passe = request.form["mot_de_passe"]
        mot_de_passe_hache = generate_password_hash(mot_de_passe)
        
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("UPDATE users SET passwords = ? WHERE id = ?", (mot_de_passe_hache, user_id))
        conn.commit()
        
        flash('Modification réussie! Connectez-vous maintenant.', 'success')

    return render_template('user_connect/connexion.html')


#FIN MOT DE PASSE OUBLIE ET RECUPERATION



#debut de la deconnexion
from flask import redirect, url_for, flash, session

#debut de la deconnexion
@app.route('/Deconnexion')
def deconnexion():
    if 'loggedin' in session:
        session.pop('loggedin', None)
        session.pop('Id', None)
        session.pop('username', None)
        flash('Vous avez été déconnecté avec succès', 'success')
    else:
        flash('Vous n’êtes pas connecté', 'warning')

    return redirect(url_for('index'))


# @app.route("/deconnexion", methods=["GET", "POST"])
# def deconnexion():
#     if request.method == "POST":
#         # Effacer la session (déconnexion)
#         user_id = session.get('Id')
#         session.clear()
#         # Exécuter une requête SQL pour récupérer les données de l'utilisateur
#         conn = pyodbc.connect(connection_string)
#         cursor = conn.cursor()
#         cursor.execute("SELECT * FROM users WHERE id = ?", user_id)
#         user_data = cursor.fetchone()

#         # Fermer la connexion
#         conn.close()
#         flash("Vous avez été déconnecté avec succès.", "success")
#         return redirect(url_for("index"))

    
#     # Afficher la page de suppression de compte avec les données de l'utilisateur
#     return render_template("user_connect/sup_compte.html", user_data=user_data)


#fin deconnexion

# DEBUT DE LA PAGE PREFERENCE
#ROUTE ==> LA PAGE PREFERENCE
@app.route('/Préférences', methods=['POST','GET'])
def preference():
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    if 'loggedin' in session: 
        with cursor.execute('SELECT * FROM nco WHERE id_user = ?', (session['Id'])) as result:
            test = result.fetchone()    
        if(test.nombre_connexion != 1):
            return redirect(url_for('accueil'))    
        if request.method == 'POST':
                try:
                    checked_options = request.form.getlist("option[]")
                    conn = pyodbc.connect(connection_string)
                    cursor = conn.cursor()
                    interests = ",".join(checked_options)

                    cursor.execute('''
                    INSERT INTO preference (interests, id_user) 
                    VALUES (?, ?)
                ''', (interests, session['Id']))

                    conn.commit()
                except Exception as e:
                # Log or handle the exception
                    print(f"Error: {e}")
                    conn.rollback()  # Roll back the transaction in case of an error
                finally:
                    conn.close()
                
                return redirect(url_for('accueil'))
        
        return render_template("user_connect/preference.html")
    else:
        return redirect(url_for('connexion'))

# FIN DE LA PAGE PREFERENCE

# @app.route('/modif_preference', methods=['POST','GET'])
# def modif_preference():
#     # code de trie et d'affichage
#     if 'loggedin' in session:

#         if request.method == 'POST':
#             checked_options = request.form.getlist("option[]")
#             conn = pyodbc.connect(connection_string)
#             cursor = conn.cursor()
#             interests = ",".join(checked_options)
#             cursor.execute('''
#                 UPDATE preference SET interests = ? 
#                 WHERE id_user = ?
#             ''', (interests, session['Id']))
#             conn.commit()
#             return redirect(url_for('accueil'))

#         # Récupérer les données de l'utilisateur pour les transmettre à la page
#         conn = pyodbc.connect(connection_string)
#         cursor = conn.cursor()
#         cursor.execute("SELECT * FROM users WHERE id = ?", session['Id'])
#         user_data = cursor.fetchone()
#         conn.close()

#         return render_template("user_connect/modif_pref.html", user_data=user_data)
#     else:
#         return redirect(url_for('connexion'))

@app.route('/modif_preference', methods=['POST','GET'])
def modif_preference():
    #code de trie et d'affichage 
    if 'loggedin' in session:

        if request.method == 'POST':  
                    checked_options = request.form.getlist("option[]")
                    conn = pyodbc.connect(connection_string)
                    cursor = conn.cursor()
                    interests = ",".join(checked_options)
                    cursor.execute('''
                    UPDATE preference SET interests = ? 
                    WHERE id_user = ?
                ''', (interests, session['Id']))
                    conn.commit()
                    return redirect(url_for('accueil'))
        # Récupérer les données de l'utilisateur
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users WHERE id = ?", session['Id'])
        user_data = cursor.fetchone()
        conn.close()
                    
        return render_template("user_connect/modif_pref.html", user_data=user_data)      
    else:
        return redirect(url_for('connexion'))
    
    
     
# DEBUT DE LA PAGE ACCCUEIL
#ROUTE ==> LA PAGE ACCUEIL
     
@app.route('/Accueil')
def accueil():
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        try:
            with conn.cursor() as cursor:
                cursor.execute('SELECT interests FROM preference WHERE id_user = ?', (session['Id'],))
                data = cursor.fetchone()

                cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
                user_data = cursor.fetchone()

                # Initialise la variable notes avec une liste vide en cas de non-respect de la première condition
                notes = []

<<<<<<< HEAD
                if data and any(keyword in data[0] for keyword in ["hotel class", "hotel chic"]):
=======
                if any(keyword in data[0] for keyword in ["Hotel class", "Hotel chic"]):
>>>>>>> 6483aff29220a07e934b2192a7b8b9fc5e5d4a41
                    cursor.execute('SELECT TOP 4 * FROM hotel')
                    data_h = cursor.fetchall()

                    # Charger les données depuis le fichier CSV avec Pandas
                    data_note = pd.read_csv('csv/NoteHot.csv', sep=';')

                    # Convertir la Series en une liste de dictionnaires
                    notes_list = [{"etablissement": etablissement, "note": note, "image": image_link} for etablissement, note, image_link in zip(data_note["Nom de l'etablissement"], data_note["Note"], data_note["liens"])]

                    # Mélanger la liste de manière aléatoire
                    random.shuffle(notes_list)

                    return render_template("accueil.html", data_h=data_h, notes=notes_list[:10], user_data=user_data)
                else:
                    print("Avant le rendu de template (condition else)")  # Ajoutez cette ligne de débogage
                    return render_template("accueil.html", data_h=None, notes=notes, user_data=user_data)
        finally:
            conn.close()
    else:
        return redirect(url_for('connexion'))


    #code de trie et d'affichage 
   


# @app.route('/navbar_data')
def navbar_data():
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        try:
            with conn.cursor() as cursor:
                cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
                user_data = cursor.fetchone()

                return render_template("partial/navbar.html", user_data=user_data)
        finally:
            conn.close()
    # else:
        # return render_template("partial/navbar.html", user_data=None)


# FIN DE LA PAGE ACCCUEIL

# DEBUT DE LA PAGE ECOLE
#ROUTE ==> LA PAGE ECOLE
@app.route('/Ecole')
def ecole():
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        try:
            with conn.cursor() as cursor:
                cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
                user_data = cursor.fetchone()

                return render_template("ecole/ecole.html", user_data=user_data)
        finally:
            conn.close()
    else:
        return render_template("ecole/ecole.html", user_data=user_data)
# FIN DE LA PAGE ECOLE

# DEBUT DE LA PAGE FILM
#ROUTE ==> LA PAGE FILM
@app.route('/Film')
def film():
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        try:
            with conn.cursor() as cursor:
                cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
                user_data = cursor.fetchone()

                return render_template("film/film.html", user_data=user_data)
        finally:
            conn.close()
    else:
        return render_template("film/film.html", user_data=user_data)
# FIN DE LA PAGE FILM

# DEBUT DE LA PAGE HOTEL
#ROUTE ==> LA PAGE HOTEL
@app.route('/Hotel')
def hotel():
 if 'loggedin' in session:
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute(" select top 30 * from hotel")
    data = cursor.fetchall()
    # connexion.close()
    cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
    user_data = cursor.fetchone()
    return render_template("hotel/hotel.html",data=data, user_data=user_data)
 else:
        return redirect(url_for('connexion'))


@app.route('/vue_hotel', methods=['GET', 'POST'])
def vue_hotel():

# Créer une variable pour le lieu
        latitude = request.args.get('latitude')
        longitude = request.args.get('longitude')

        print(latitude)
        try:
            lat = float(latitude)
            long = float(longitude)
        except ValueError:
            return 'Les coordonnées doivent être des nombres'
        lieu = {
            "latitude": lat,
            "longitude": long,
                } 
        carte_unique = folium.Map(location=[lat,long], zoom_start=10)
        marqueur = folium.Marker(location=[latitude, longitude],popup="Paris",icon=folium.Icon(icon='star', color='red', prefix='fa'))
        marqueur.add_to(carte_unique)

        path = os.path.join(app.root_path, "templates", "carte_unique.html")  
        if os.path.exists(path):  
            os.remove(path)

        with open(path, "w" ,encoding="utf-8" ) as f: 
            f.write(carte_unique.get_root().render())

        return redirect(url_for("vue_unique_hotel"))
    
    

@app.route("/vue_unique_hotel")
def  vue_unique_hotel():
    if 'loggedin' in session: 
         path = os.path.join(app.root_path, "templates", "carte_unique.html")
         if os.path.exists(path):
          return render_template("carte_unique.html")
         else:
             return redirect(url_for('hotel'))
    else:
      return redirect(url_for('connexion'))
    


@app.route("/carte")
def carte():
 if 'loggedin' in session: 
    df = pd.read_csv("data/hotel.csv")
    print(df.columns)
# Assurez-vous que les colonnes 'latitude' et 'longitude' sont numériques
    df['latitude'] = pd.to_numeric(df['latitude'], errors='coerce')
    df['longitude'] = pd.to_numeric(df['longitude'], errors='coerce')
# Créer une carte centrée sur une position spécifique
    ma_carte = folium.Map(location=[df['latitude'].mean(), df['longitude'].mean()], zoom_start=10)
# Créer un cluster de marqueurs
    marker_cluster = MarkerCluster().add_to(ma_carte)
# Ajouter des marqueurs à la carte à partir du DataFrame
    for index, row in df.iterrows():
        folium.Marker([row['latitude'], row['longitude']], popup=row["Nom de l'etablissement"]).add_to(marker_cluster)

# Enregistrer la carte au format HTML
        
    path = os.path.join(app.root_path, "templates", "ma_carte.html")  # Chemin complet vers le fichier de la carte
    if os.path.exists(path):  # Vérification de l'existence du fichier
        os.remove(path)  # Suppression du fichier existant

    with open(path, "w" ,encoding="utf-8" ) as f:  # Ouverture du fichier en mode écriture
        f.write(ma_carte.get_root().render()) # Écriture du contenu HTML de la carte
    return redirect(url_for('vue'))
 else:
     return redirect(url_for('connexion'))
# FIN DE LA PAGE HOTEL
 
@app.route('/vue')
def vue():
    if 'loggedin' in session: 
         path = os.path.join(app.root_path, "templates", "ma_carte.html")
         if os.path.exists(path):
          return render_template("ma_carte.html")
         else:
             return redirect(url_for('carte'))
    else:
      return redirect(url_for('connexion'))
    
         
     

# DEBUT DE LA PAGE RESTAURANTS
#ROUTE ==> LA PAGE RESTAURANTS
@app.route('/Restaurant')
def restaurant():
    user_id = session.get("Id")
    print(user_id)
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute(" select * from restaurant")
        data = cursor.fetchall()
        cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
        user_data = cursor.fetchone()
        return render_template("restaurant/restaurant.html",data=data, user_data = user_data)
    else:
        return redirect(url_for('connexion'))
# FIN DE LA PAGE RESTAURANTS

############# TEST_NOTE ##############
@app.route('/note')
def note():
    # Charger les données depuis le fichier CSV avec Pandas
    data = pd.read_csv('csv/note.csv')

    # Convertir la Series en une liste de dictionnaires
    notes_list = [{"etablissement": etablissement, "note": note} for etablissement, note in zip(data["Nom de l'etablissement"], data["Note"])]

    # Mélanger la liste de manière aléatoire
    random.shuffle(notes_list)

    return render_template('Test_app/note.html', notes=notes_list[:10])








<<<<<<< HEAD
=======

#dashoard
# app.config['SQL_SERVER_CONNECTION_STRING'] = """
#     Driver={SQL Server};
#     Server=MTN-Academy\SQLEXPRESS;
#     Database=ivorydb;
#     Trusted_Connection=yes;"""
@app.route('/dashbord',methods = ['POST', 'GET'])
def dashbord():
    #  if 'loggedin' in session:
    # if session['role'] != 'admin':
    #     return redirect(request.referrer)
    # else:
    conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
    cursor = conn.cursor()
    cursor.execute("select  * from users")
    # cursor.execute(""" SELECT * FROM Transfert """)
    data = cursor.fetchall()
    nbr_user=len(data)
    conn.commit()
    conn.close()
    return render_template("dashbord.html" , data1=data, nbr_user=nbr_user)
    # return redirect(url_for('connexion'))

>>>>>>> 6483aff29220a07e934b2192a7b8b9fc5e5d4a41
if __name__ == "__main__":
    app.run(debug=True,port=3000)

