from flask import Flask, render_template, url_for, request, redirect, flash, session
import pyodbc
import re
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

    # Initialisation de l'extension Flask-WTF


# app.config['SECRET_KEY'] ='clés_flash'
# DRIVER_NAME = 'SQL SERVER'
# SERVER_NAME = 'DESKTOP-02KB7J2'
# DATABASE_NAME = 'ivoryExplore'

app.config['SQL_SERVER_CONNECTION_STRING'] = """
    Driver={SQL Server};
    Server=DESKTOP-K074SIS\SQLEXPRESS;
    Database=IvoryExplore;
    Trusted_Connection=yes;"""



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
                INSERT INTO users (nom_user,prenom_user, username, email, Passwords)
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
     
@app.route('/Accueil')
def accueil():
    if 'loggedin' in session:
     conn = pyodbc.connect(connection_string)  # Connect to the database
     try:
         with conn.cursor() as cursor:
            
            cursor.execute('SELECT interests FROM preference WHERE id_user = ?', (session['Id'],))
            data = cursor.fetchone()
            
            if any(keyword in data[0] for keyword in ["hotel class", "hotel chic"]):
                cursor.execute('SELECT TOP 4 * FROM hotel')
                data_h = cursor.fetchall()
                return render_template("accueil.html", data_h=data_h)
            else:
                return render_template("accueil.html", data_h=None)
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

    with open(path, "w" ,encoding="utf-8") as f:  # Ouverture du fichier en mode écriture
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


if __name__ == "__main__":
    app.run(debug=True,port=3000)
