pub struct Config {
    pub address_and_port: String,
}

impl Config {
    pub fn new() -> Self {
        dotenv::dotenv().ok();
        let address_and_port =
            std::env::var("ADDRESS_AND_PORT").expect("ADDRESS_AND_PORT must be set.");

        Config { address_and_port }
    }
}
