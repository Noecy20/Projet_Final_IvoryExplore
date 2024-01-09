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
    "Server=Geek_Machine\SQLEXPRESS;"
    "Database=ivoryExplore;"
    "Trusted_Connection=yes"
)



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
@app.route('/Inscription',methods=["GET", "POST"])
def inscription():
    if request.method == 'POST':
        nom_user = request.form["nom_user"]
        prenom_user = request.form["prenom_user"]
        username = request.form["username"]
        email = request.form["email"]
        passwords = request.form["passwords"]
        hashed_password = generate_password_hash(passwords)

        conn = pyodbc.connect(connection_string)
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
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            c = cursor.execute('''
                INSERT INTO users (nom_user,prenom_user, username, email, passwords)
                VALUES ( ?, ?, ?, ?, ?)
             ''', (nom_user,prenom_user,username, email, hashed_password))
        
            cursor.execute('''
                  select id from users  where email = ? and  username=?
             ''', ( email,username))
                
            i = cursor.fetchone()

            cursor.execute('''
                INSERT INTO nco (id_user,nombre_connexion)
                VALUES (?, ?)
             ''', (i.id, 0))
            
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
        email = request.form["email"]
        passwords = request.form["passwords"]
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM users WHERE email = ?', (email))
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
        
        #mot_de_passe_hache = bcrypt.generate_password_hash(mot_de_passe).decode('utf-8')
        # Génération du sel (salt)
        salt = bcrypt.gensalt()
        # Hachage du mot de passe avec le sel
        mot_de_passe_hache = bcrypt.hashpw(mot_de_passe.encode('utf-8'), salt).decode('utf-8')
        
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute(f"UPDATE users SET passwords = ? WHERE id = ?", (mot_de_passe_hache, user_id))
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
    
    
     
# FIN DE LA PAGE ACCCUEIL

# DEBUT DE LA PAGE ACCCUEIL
#ROUTE ==> LA PAGE ACCUEIL
     
@app.route('/Accueil_hotel')
def accueil_hotel():
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        try:
            with conn.cursor() as cursor:
                cursor.execute('SELECT * FROM users WHERE id = ?', (session['Id'],))
                user_data = cursor.fetchone()
                cursor.execute('SELECT interests FROM preference WHERE id_user = ?', (session['Id'],))
                data = cursor.fetchone()

                if any(keyword in data[0] for keyword in ["hotel class", "hotel chic"]):
                    cursor.execute('SELECT TOP 4 * FROM hotel')
                    data_h = cursor.fetchall()

                    # Charger les données depuis le fichier CSV avec Pandas
                    data_note = pd.read_csv('csv/NoteHot.csv',  sep=';')

                    # Convertir la Series en une liste de dictionnaires
                    #notes_list = [{"etablissement": etablissement, "note": note} for etablissement, note in zip(data_note["Nom de l'etablissement"], data_note["Note"])]
                    notes_list = [{"etablissement": etablissement, "note": note, "image": image_link} for etablissement, note, image_link in zip(data_note["Nom de l'etablissement"], data_note["Note"], data_note["liens"])]

                    # Mélanger la liste de manière aléatoire
                    random.shuffle(notes_list)

                    return render_template("partial/accueil_hotel.html", data_h=data_h, notes=notes_list[:10],user_data=user_data)
                else:
                    return render_template("partial/accueil_hotel", data_h=None, notes=None,user_data=user_data)
        finally:
            conn.close()
    else:
        return redirect(url_for('connexion'))          

    #code de trie et d'affichage 
   
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
 if 'loggedin' in session:
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute(" select top 30 * from hotel")
    data = cursor.fetchall()
    # connexion.close()
    return render_template("hotel/hotel.html",data=data)
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
    if 'loggedin' in session:
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute(" select * from restaurant")
        data = cursor.fetchall()
        return render_template("restaurant/restaurant.html",data=data)
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








if __name__ == "__main__":
    app.run(debug=True,port=3000)
