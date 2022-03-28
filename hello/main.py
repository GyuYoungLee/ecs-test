from datetime import datetime
from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
def health_check():
    return {
        "message": "checked"
    }


@app.get("/hello")
def say_hello():
    return {
        "message": datetime.now().replace(microsecond=0).isoformat(" ")
    }
