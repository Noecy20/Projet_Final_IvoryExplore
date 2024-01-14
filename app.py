
from flask import Flask,render_template, url_for, request, redirect, flash, session
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
    "Server=DESKTOP-T61GK5V\SQLEXPRESS01;"
    "Database=Script_ivory;"
    "Trusted_Connection=yes"
)


# ? Configuration pour le stockage des images du parent et du répétiteur
# ? Configuration pour le stockage des images du parent et du répétiteur
UPLOAD_FOLDER_PARENT = 'static/uploads/images_profil_parent'
app.config['UPLOAD_FOLDER_PARENT'] = UPLOAD_FOLDER_PARENT
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['SESSION_TYPE'] = 'filesystem'

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


#UPLOAD_FOLDER_PARENT = 'static/uploads/images_profil_parent'
#app.config['UPLOAD_FOLDER_PARENT'] = UPLOAD_FOLDER_PARENT

# Route pour la modification du profil via une requête AJAX
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


# Profil utilisateur

app.config['SQL_SERVER_CONNECTION_STRING'] = """
    Driver={SQL Server};
    Server=MTN-Academy\SQLEXPRESS;
    Database=ivorydb;
    Trusted_Connection=yes;"""



#PREMIERE ROUTE ==> LA PREMIERE PAGE POUR LE USER
@app.route('/')
def index():
    
    return render_template("index.html")

# DEBUT DE LA PAGE dasbord
# ROUTE ==> LA PAGE dasbord

# @app.route('/dashbord')
# def dash():
#     return render_template("dashbord.html")

# @app.route('/dashbord')
# def dash():
#     return render_template("dashbord.html")


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
# @app.route('/connexion',methods=["GET", "POST"])

@app.route('/Connexion',methods=["GET", "POST"])
def connexion():

    #conn = pyodbc.connect(app.config['SQL_SERVER_CONNECTION_STRING'])
    #cursor = conn.cursor()
    # cursor.execute("SELECT * FROM users where email=?",(email,))
    #user = cursor.fetchone()
    #session["user"]=user
    
    if request.method == 'POST':
        email = request.form["email"]  # Utilisateur peut saisir l'e-mail ou le nom d'utilisateur
        passwords = request.form["passwords"]
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE email = ?', (email,))
        cursor.execute('SELECT * FROM users WHERE email = ? OR username = ?', (email, email))
        users = cursor.fetchone()
        if users:
            user_pswd = users[5]

            if check_password_hash(user_pswd, passwords):

                session['loggedin'] = True
                session['Id'] = users[0]
                session['username'] = users[1]
                session['role']=users[6]
                print(session['role'])
                return redirect(url_for('accueil'))

              # Utilisation du contexte 'with' pour la requête SELECT
                with cursor.execute('SELECT * FROM nco WHERE id_user = ?', (session['Id'])) as result:
                    test = result.fetchone()

                compte = test.nombre_connexion + 1
                cursor.execute('UPDATE nco SET nombre_connexion = ? WHERE id_user = ?', (compte, session['Id']))
                conn.commit()
                conn.close()

                if compte == 1:
                    return redirect(url_for('user_connect/preference'))
                else:
                    return redirect(url_for('accueil'))
            else:
                flash("Mot de passe incorrect !", 'info')
                return redirect(url_for('user_connect/connexion.html'))
        else:
            flash("Identifiant incorrect !", 'info')
            return redirect(url_for('user_connect/connexion.html'))


        flash("Identifiant incorrect !", 'info')
        return redirect(url_for('user_connect/connexion'))
    
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
@app.route('/Deconnexion')
def deconnexion():
    if 'loggedin' in session:
        session.pop('loggedin', None)
        session.pop('Id', None)
        session.pop('username', None)
        flash('You have been successfully logged out', 'success')
    else:
        flash('You are not logged in', 'warning')

    return redirect(url_for('index'))
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
                    
        return render_template("user_connect/modif_pref.html")      
    else:
        return redirect(url_for('connexion'))
    
    
     
# DEBUT DE LA PAGE ACCCUEIL
#ROUTE ==> LA PAGE ACCUEIL
     
from flask import render_template

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

                if any(keyword in data[0] for keyword in ["hotel class", "hotel chic"]):
                    cursor.execute('SELECT TOP 4 * FROM hotel')
                    data_h = cursor.fetchall()

                    # Charger les données depuis le fichier CSV avec Pandas
                    data_note = pd.read_csv('csv/NoteHot.csv',  sep=';')

                    # Convertir la Series en une liste de dictionnaires
                    notes_list = [{"etablissement": etablissement, "note": note, "image": image_link} for etablissement, note, image_link in zip(data_note["Nom de l'etablissement"], data_note["Note"], data_note["liens"])]

                    # Mélanger la liste de manière aléatoire
                    random.shuffle(notes_list)

                    return render_template("accueil.html", data_h=data_h, notes=notes_list[:10], user_data = user_data)
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









#dashoard
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

if __name__ == "__main__":
    app.run(debug=True,port=3000)
