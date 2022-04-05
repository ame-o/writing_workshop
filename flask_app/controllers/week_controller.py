from flask import render_template, redirect, request,flash, session
from flask_app import app

from flask_app.models.vocab_model import Vocab
from flask_app.models.user_model import User
from flask_app.models.week_model import Weekly

from flask_app.controllers import user_controller

#==========================================================
#   Misc
# =========================================================

@app.route('/slideshow')
def view_slideshow():
    if "user_id" not in session:
        return redirect('/lost')
    data_query = {
        "id": session["user_id"]
    }
    logged_in = User.get_by_id(data_query)
    return render_template("slideshow.html",logged_in=logged_in)


#========================================================== 
#View One week --> send to database
# =========================================================
# @app.route('/dateverify', methods=['POST'])
# def find_week():
#     week_id = {
#         "week_id" : int(request.form['currentDate'])
#     }
#     Weekly.weekly_week(week_id)
#     return redirect(f'/view/week/{week_id}')

#========================================================== 
#Create New week --> send to database
# =========================================================


@app.route('/new/weekly')
def new_week():
    if "user_id" not in session:
        return redirect('/lost')
    user_id = session["user_id"]
    query_data = {
        "id": session["user_id"]
    }
    logged_in = User.get_by_id(query_data)
    return render_template('add_week.html',user_id=user_id,logged_in=logged_in)

# =========================================================
@app.route('/new/weekly/process', methods = ['POST'])
def create_week():
    if not Weekly.validate_add(request.form):
        return redirect("/new/weekly")
    query_data = {
        "vocab" : request.form["vocab"],
        "vocab_story" : request.form["vocab_story"],
        "hamburger_1" : request.form["hamburger_1"],
        "hamburger_2" : request.form["hamburger_2"],
        "essay_1" : request.form["essay_1"],
        "essay_2" : request.form["essay_2"],
        "week_id" : request.form["week_id"],
        "user_id" : request.form["user_id"]
            }
    Weekly.create_instance(query_data)
    return redirect("/dashboard") 

#========================================================== 
# edit existing week --> send to database
# =========================================================
@app.route('/edit/weekly/<int:id>')
def form_edit_week(id): 
    if "user_id" not in session:
        return redirect('/lost')
    user_id = session["user_id"]
    query_data = {
        "id": session["user_id"]
    }
    logged_in = User.get_by_id(query_data)
    data = {
        "id" : id
    }
    one_week= Weekly.get_one_instance(data)
    return render_template('edit_week.html',user_id=user_id,logged_in=logged_in,one_week=one_week)

#========================================================== 
@app.route('/edit/weekly/process', methods = ['POST'])
def process_edit_week():
    if not Weekly.validate_add(request.form):
        w_id = int(request.form['id'])
        return redirect(f"/edit/weekly/{w_id}")
    query_data = {
        "vocab" : request.form["vocab"],
        "vocab_story" : request.form["vocab_story"],
        "hamburger_1" : request.form["hamburger_1"],
        "hamburger_2" : request.form["hamburger_2"],
        "essay_1" : request.form["essay_1"],
        "essay_2" : request.form["essay_2"],
        "week_id" : request.form["week_id"],
        "user_id" : request.form["user_id"]
            }
    Weekly.edit_instance(query_data)
    return redirect ("/dashboard")

#========================================================== 
# delete existing week --> send to database
# =========================================================
@app.route('/delete/week/<int:id>')
def delete_week(id):
    if "user_id" not in session:
        return redirect('/lost')
    data = {
        "id" : id
    }
    Weekly.delete_instance(data)
    return redirect("/dashboard")