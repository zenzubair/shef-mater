# Store this code in 'app.py' file
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re

app = Flask(__name__)

app.secret_key = 'your secret key'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '12345678'
app.config['MYSQL_DB'] = 'flask_adv'

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/about')
def about():
    return render_template("about.html")

@app.route('/menu')
def menu():
    return render_template('menu.html')

# @app.route('/contact')
# def contact():
#     return render_template('contact.html')

@app.route('/team')
def team():
    return render_template('team.html')

@app.route('/features')
def features():
    return render_template('feature.html')

@app.route('/blog')
def blog():
    return render_template('blog.html')

@app.route('/testimonial')
def testimonial():
    return render_template('testimonial.html')

@app.route('/404')
def page_not_found():
    return render_template('404.html')

@app.route('/contact')
def contact():
    msg=''
    return render_template('contact.html', msg= msg)   

@app.route('/user_form', methods=['GET', 'POST'])
def user_form():
    msg=''
    if request.method=='POST' and 'user_name' in request.form and 'email' in request.form and 'subject' in request.form and 'message' in request.form:
        user_name = request.form['user_name']
        user_email = request.form['email']
        subject = request.form['subject']
        user_message = request.form['message']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute( 'INSERT INTO users VALUES (NULL, % s, % s, % s, % s)', (user_name,user_email,subject,user_message) )
        mysql.connection.commit()
        msg= "your message have been sent"
    else:
        msg= "Please fill the form"
    return render_template('contact.html', msg= msg)

@app.route('/un_subscribe' , methods=['POST'])
def user_unsubscribe():
    msg=""
    if request.method=='POST' and 'user_sub_email' in request.form:
        user_email = request.form['user_sub_email']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('DELETE FROM subscribers where user_email = % s',(user_email, ))
        mysql.connection.commit()
        msg=" you have successfully Un Subscribed"  
    else:
        msg=" Plesase enter the email address"
    return render_template('contact.html',msg=msg)

@app.route('/subscribe' , methods=["POST"])
def user_subscribe():
    msg=""
    if request.method=='POST' and 'user_sub_email' in request.form:
        user_email = request.form['user_sub_email']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * from subscribers where user_email = % s',(user_email, ))
        u_subs = cursor.fetchone()
        if u_subs:
            msg=" you have already subscribed"
            u_subs=u_subs['user_email']
        else:    
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('INSERT INTO subscribers (user_email) values (%s)',(user_email,))
            mysql.connection.commit()
            msg=" you have Successfully subscribed"
    return render_template('contact.html',msg=msg , u_subs=u_subs )

if __name__ == "__main__":
    app.run(host="localhost", port=int("5000"))