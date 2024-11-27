import sys
from flask import Flask
from test import firstTest
app = Flask(__name__)


@app.route("/")
def hello():
	print (sys.argv)
#	print("test")
	return "<h1>hello<h1>"
    #return firstTest("Nathan")

if __name__ == "__main__":
	hello()
#    app.run(host='0.0.0.0')
