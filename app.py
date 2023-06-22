from flask import Flask, request, jsonify
import mariadb
import dbcreds

app = Flask(__name__)

# Function to establish a connection with MariaDB
def get_db_conn():
    conn = mariadb.connect(
        user=dbcreds.user,
        password=dbcreds.password,
        host=dbcreds.host,
        port=dbcreds.port,
        database=dbcreds.database
    )
    return conn

@app.route('/signup', methods=['POST'])
def signup():
    username = request.json.get('username')
    email = request.json.get('email')
    password = request.json.get('password')
    bio = request.json.get('bio')
    image_url = request.json.get('image_url')

    conn = get_db_conn()
    cur = conn.cursor()

    # Execute stored procedure
    cur.callproc('create_client', [username, email, password, bio, image_url])
    
    # Fetch result data
    data = cur.fetchone()

    # Always close the cursor and connection
    cur.close()
    conn.close()

    return jsonify(data)

# Similarly, create routes for login, getting user profile and logout.

if __name__ == "__main__":
    app.run(debug=True)
