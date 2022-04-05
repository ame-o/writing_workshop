from flask_app import app
#controllers
from flask_app.controllers import user_controller, vocab_controller, week_controller



if __name__ == "__main__":
    app.run(debug = True)