from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
from mangum import Mangum

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

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
