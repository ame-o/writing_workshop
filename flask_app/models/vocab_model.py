from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash
from flask_app import app
from flask_bcrypt import Bcrypt
bcrypt= Bcrypt(app)

from flask_app.models import user_model
from flask_app.models import week_model

class Vocab:
    def __init__(self,data):
        self.id = data["id"]
        self.spelling = data["spelling"]
        self.definition = data["definition"]
        self.sentence = data["sentence"]
        self.due_date = data["due_date"]
        self.week_id = data["week_id"]
        self.user_id = data["user_id"]

# =========================================================
    #Static Methods
# =========================================================
    @staticmethod
    def validate_add(form_data):
        is_valid = True
        if len(form_data['spelling']) < 2:
            flash("Spelling must be at least 2 characters")
            is_valid=False
        if len(form_data['definition']) < 2:
            flash("Definition must be at least 2 characters")
            is_valid=False
        return is_valid

# =========================================================
    #get all instances in vocabs and users <- from database
# =========================================================
    @classmethod
    def one_to_one(cls):
        query = """SELECT * FROM vocabulary
        JOIN users ON users.id= vocabulary.user_id;"""
        results = connectToMySQL("writing_workshop").query_db(query)
        all_all = []
        for dic in results:
            vocab_data = {
                "id" : dic["id"],
                "spelling" : dic["spelling"],
                "definition" : dic["definition"],
                "sentence" : dic["sentence"],
                "due_date" : dic["due_date"],
                "week_id" : dic["week_id"],
                "user_id" : dic["user_id"]
            }
            vocab = cls(vocab_data)
            user_data = {
                "id" : dic['user_id'],
                "first_name" : dic['first_name'],
                "username" : dic['username'],
                "password" : dic['password']
            }
            vocab.user = user_model.User(user_data)
            all_all.append(vocab)
        return all_all


# =========================================================
    #Get an instance <- send to database
# =========================================================

    @classmethod
    def get_one_instance(cls,data):
        query = "SELECT * FROM vocabulary JOIN users ON vocabulary.user_id = users.id WHERE vocabulary.id = %(id)s;"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        if results:
            vocabulary= cls(results[0])
            vocabulary.creator = user_model.User(results[0])
            return vocabulary
# =========================================================
    #create new instance of a vocab
# =========================================================
    @classmethod
    def create_instance(cls,data):
        query = "INSERT INTO vocabulary (spelling,definition,sentence,due_date,week_id,user_id) VALUES (%(spelling)s,%(definition)s,%(sentence)s,%(due_date)s,%(week_id)s,%(user_id)s);"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        return results

# =========================================================
    # edit one instance in vocab -> send to database
# =========================================================
    @classmethod
    def edit_instance(cls,data):
        query = "UPDATE vocabulary SET spelling=%(spelling)s, definition=%(definition)s, sentence=%(sentence)s, due_date=%(due_date)s,week_id=%(week_id)s WHERE id = %(id)s;"
        return connectToMySQL("writing_workshop").query_db(query,data)


# =========================================================
    #delete an instance in vocab -> send to database
# =========================================================
    @classmethod
    def delete_instance(cls,data):
        query = "DELETE FROM vocabulary WHERE id = %(id)s;"
        return connectToMySQL("writing_workshop").query_db(query,data)

#=============================================================
#   show by week_id
#=============================================================
    @classmethod
    def vocab_week(cls,data):
        query = "SELECT * from vocabulary WHERE vocabulary.user_id=1 AND vocabulary.week_id = %(week_id)s;"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        if results:
            return results