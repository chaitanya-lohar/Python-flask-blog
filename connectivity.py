from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
from tkinter import messagebox
from flask import flash
from werkzeug.utils import secure_filename
import os
import math
with open('config.json','r') as c:
    parameters=json.load(c)["parameter"]
localserver=True
app=Flask(__name__)
app.secret_key = "secret_key"

if (localserver):

    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['host_uri']
db=SQLAlchemy(app)

app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT']=465
app.config['MAIL_USE_SSL']=True
app.config['MAIL_USE_TLS']=False
app.config['MAIL_USERNAME']=parameters['gmail_user']
app.config['MAIL_PASSWORD']=parameters['gmail_password']

mail=Mail(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),nullable=False)
    email = db.Column(db.String(120),nullable=False)
    phone_no = db.Column(db.String(12),nullable=False)
    message = db.Column(db.String(120),nullable=False)
    date = db.Column(db.String(20),nullable=True)

class posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80),nullable=False)
    sub_heading = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(120),nullable=False)
    content = db.Column(db.String(300),nullable=False)
    img_file = db.Column(db.String(30), nullable=False)
    date = db.Column(db.String(20),nullable=True)

class login(db.Model):
    id=db.Column(db.Integer, primary_key=True)
    admin_name = db.Column(db.String(12), nullable=False)
    admin_password = db.Column(db.String(12), nullable=False)


@app.route("/")
def index():
    post = posts.query.filter_by().all()
    last=math.ceil(len(post)/4)
    page=(request.args.get('page'))

    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    post=post[(page-1)*4:(page-1)*4+4]
    if(page==1):
        prev="#"
        next="/?page="+str(page+1)
    elif(page==last):
        prev="/?page="+str(page-1)
        next="#"
    else:
        prev="/?page="+str(page-1)
        next="/?page="+str(page+1)


    return render_template("index.html",image='home-bg.jpg',parameters=parameters,post=post,prev=prev,next=next) #  render_template is a function use to render html page on brower

@app.route("/login",methods=['POST','GET'])
def loginpage():
    if(request.method=='POST'):
        myname=request.form.get('login_name')
        mypassword=request.form.get('login_password')
        log=login.query.filter_by(admin_name=myname,admin_password=mypassword).first()
        post=posts.query.all()
        if(log==None):
            session['user_name'] = ""
            return render_template("login.html")
        else:
            session['user_name']=log.admin_name
            flash("you are successfuly logged in")
            return redirect("/dashboard")

    return render_template("login.html")


@app.route("/dashboard",methods=['POST','GET'])
def dashboard():
    if ('user_name' in session):
        post = posts.query.all()
        return render_template("dashboard/dashboard.html", parameters=parameters, post=post, sess=session['user_name'])
    else:
        return redirect("/login")

@app.route("/logout",methods=['POST','GET'])
def logout():
    session.pop('user_name')
    flash('you are successfully logout!')
    return redirect("/login")

@app.route("/dashboard/add/<string:sno>" ,methods=['GET','POST'])
def add(sno):
    if ('user_name' in session):
        if request.method=='POST':
            title = request.form.get('title')
            sub_heading = request.form.get('sub_heading')
            slug = request.form.get('slug')
            content = request.form.get('content')
            image = request.form.get('img_file')
            date = datetime.now()

            if(sno=='0'):
                entry=posts(title=title,sub_heading=sub_heading,slug=slug,content=content,img_file=image,date=date)
                db.session.add(entry)
                db.session.commit()

                flash('New post successfully added', 'success')
    else:
        return redirect("/login")


    return render_template("add.html", parameters=parameters, sno=sno)



@app.route("/dashboard/delete/<string:sno>",methods=['GET','POST'])
def delete(sno):
    if ('user_name' in session):
        db.session.delete(posts.query.get(sno))
        db.session.commit()
        flash('Post has been deleted!','success')
        return redirect('/dashboard')
    else:
        return redirect("/login")

@app.route("/dashboard/uploader",methods=['GET','POST'])
def upload():
    if request.method=="POST":
        file=request.files['file1']
        if(file.filename==''):
            flash('No selected file','warning')
            return redirect("/dashboard")
        else:
            file.save(os.path.join("C:\\Users\\Education\\PycharmProjects\\HARRY\\static\\uploads",secure_filename(file.filename)))
            flash("File successfully uploaded...")
            return redirect("/dashboard")



@app.route("/dashboard/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if ('user_name' in session):
        if request.method == 'POST':
            title = request.form.get('title')
            sub_heading = request.form.get('sub_heading')
            slug = request.form.get('slug')
            content = request.form.get('content')
            image = request.form.get('img_file')
            date = datetime.now()

            post=posts.query.filter_by(sno=sno).first()
            post.title=title
            post.sub_heading=sub_heading
            post.slug=slug
            post.content=content
            post.img_file=image
            post.date=date
            db.session.commit()
            flash('Sucessfully post edited', 'success')
            return redirect("/dashboard")

        post=posts.query.filter_by(sno=sno).first()
        return render_template("edit.html", parameters=parameters, post=post)
    else:
        return redirect("/login")

# @app.route("/layout")
# def layout():
#     return render_template("layout.html",parameters=parameters)



@app.route("/about")
def about():
    return render_template("about.html",image="about-bg.jpg",parameters=parameters)

@app.route("/contact",methods=['GET','POST'])
def contact():
    if(request.method=='POST') :

        username=request.form.get('name')
        useremail=request.form.get('email')
        userphone_no=request.form.get('phone_no')
        usermessage=request.form.get('message')

        entry=Contacts(name=username,email=useremail,phone_no=userphone_no,message=usermessage,date=datetime.now())
        db.session.add(entry)
        db.session.commit()

        mail.send_message('new email from'+username,
                          sender=useremail,
                          recipients=[parameters["gmail_user"]],
                          body=usermessage+"\n"+userphone_no)

    return render_template("contact.html",image="contact-bg.jpg",parameters=parameters)


@app.route("/post/<string:first_post>",methods=['GET'])
def post_route(first_post):
    post=posts.query.filter_by(slug=first_post).first()
    print(post.img_file)

    return render_template("post.html",image=post.img_file,parameters=parameters,post=post)

app.run(debug=True)

