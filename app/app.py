from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
import logging

# Configure Logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("platform-demo")

# Create FastAPI app
app = FastAPI(
    title="Platform Demo API",
    description="A simple FastAPI application for kubernetes platform demonstration.",
    version="1.0.0"
)

# Enable Prometheus metrics
Instrumentator().instrument(app).expose(app)

# Startup log
@app.on_event("startup")
async def startup_event():
    logger.info("Starting API application...")

# Health check endpoint
@app.get("/health")
async def health():
    logger.info("Health check endpoint called.")
    return {"status": "healthy"}

# Status endpoint
@app.get("/api/status")
async def status():
    logger.info("Status endpoint called.")
    return {
        "service": "platform-demo",
        "environment": "production",
        "status": "running"
    }
