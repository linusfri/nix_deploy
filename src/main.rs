use axum::{routing::get, Json, Router};
use nix_deploy::config;

#[tokio::main]
async fn main() {
    let app = api_router();
    let config = config::Config::new();

    let listener = tokio::net::TcpListener::bind(config.address_and_port)
        .await
        .unwrap();

    axum::serve(listener, app).await.unwrap();
}

async fn root() -> Json<String> {
    Json(String::from("Ping"))
}

fn root_router() -> Router {
    Router::new().route("/", get(root))
}

fn api_router() -> Router {
    root_router()
}
