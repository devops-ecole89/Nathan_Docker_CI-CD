import sys
from flask import Flask
from test import firstTest
app = Flask(__name__)


@app.route("/")
def hello():
	return "<h1>hello<h1>"

def main():
	if sys.argv[1] == "-dev":
	print (sys.argv)
	else:
	app.run(host='0.0.0.0')
#	print("test")
    #return firstTest("Nathan")

if __name__ == "__main__":
	main()
#    app.run(host='0.0.0.0')
