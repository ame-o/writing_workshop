from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash
from flask_app import app
from flask_bcrypt import Bcrypt
bcrypt= Bcrypt(app)

from flask_app.models import user_model
from flask_app.models import vocab_model

class Weekly:
    def __init__(self,data):
        self.id = data["id"]
        self.vocab = data["vocab"]
        self.vocab_story = data["vocab_story"]
        self.hamburger_1 = data["hamburger_1"]
        self.hamburger_2 = data["hamburger_2"]
        self.essay_1 = data["essay_1"]
        self.essay_2 = data["essay_2"]
        self.week_id = data["week_id"]
        self.user_id = data["user_id"]

# =========================================================
    #Static Methods
# =========================================================
    @staticmethod
    def validate_add(form_data):
        is_valid = True
        if len(form_data['hamburger_1']) < 2:
            flash("Please write n/a if not applicable!")
            is_valid=False
        if len(form_data['essay_1']) < 2:
            flash("Please write n/a if not applicable!")
            is_valid=False
        if len(form_data['week_id']) < 0:
            flash("Please pick a week!")
            is_valid=False

        return is_valid
# =========================================================
    #Get an instance <- send to database
# =========================================================

    @classmethod
    def get_one_instance(cls,data):
        query = "SELECT * FROM weekly JOIN users ON weekly.user_id = users.id WHERE weekly.id = %(id)s;"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        if results:
            weekly= cls(results[0])
            return weekly

# =========================================================
    #create new instance of a band
# =========================================================
    @classmethod
    def create_instance(cls,data):
        query = "INSERT INTO weekly (vocab, vocab_story, hamburger_1, hamburger_2, essay_1, essay_2, week_id,user_id) VALUES (%(vocab)s, %(vocab_story)s, %(hamburger_1)s, %(hamburger_2)s, %(essay_1)s, %(essay_2)s, %(week_id)s,%(user_id)s)"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        return results

# =========================================================
    # edit one instance in band -> send to database
# =========================================================
    @classmethod
    def edit_instance(cls,data):
        query = "UPDATE weekly SET vocab=%(vocab)s, vocab_story=%(vocab_story)s, hamburger_1=%(hamburger_1)s, hamburger_2=%(hamburger_2)s, essay_1=%(essay_1)s, essay_2=%(essay_2)s, week_id=%(week_id)s;"
        return connectToMySQL("writing_workshop").query_db(query,data)


# =========================================================
    #delete an instance in band -> send to database
# =========================================================
    @classmethod
    def delete_instance(cls,data):
        query = "DELETE FROM weekly WHERE id = %(id)s;"
        return connectToMySQL("writing_workshop").query_db(query,data)

#=============================================================
#   show by week_id
#=============================================================
    @classmethod
    def weekly_week(cls,data):
        query = "SELECT * from weekly WHERE user_id=1 AND weekly.week_id= %(week_id)s;"
        results = connectToMySQL("writing_workshop").query_db(query, data)
        if results:
            weekly= cls(results[0])
            return weekly
