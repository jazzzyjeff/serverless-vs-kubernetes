from fastapi import FastAPI
from datetime import datetime
from mangum import Mangum

app = FastAPI()
visits = 0

@app.get("/")
def read_root():
    return {"message": "Hello World"}

@app.get("/time")
def get_time():
    return {"time": datetime.utcnow().isoformat()}

@app.get("/visits")
def get_visits():
    global visits
    visits += 1
    return {"visits": visits}

@app.get("/home/{name}")
def home(name: str):
    return {"message": f"Hello, {name}!"}

lambda_handler = Mangum(app)
