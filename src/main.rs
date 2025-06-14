mod commands;
mod handlers;
mod services;
mod db;
mod errors;

use dotenvy::dotenv;
use std::env;
use sentry::ClientInitGuard;
use teloxide::prelude::*;
use teloxide::dispatching::UpdateFilterExt;
use teloxide::types::Update;
use teloxide::utils::command::BotCommands;
use log::info;

#[tokio::main]
async fn main() {
    dotenv().ok();
    let _sentry = init_sentry();
    env_logger::init();
    let bot = Bot::from_env();
    info!("Starting McFriendo bot...");

    // Webhook setup (placeholder)
    // TODO: Реализовать установку вебхука через BASE_WEBHOOK_URL

    Dispatcher::builder(bot, schema())
        .enable_ctrlc_handler()
        .build()
        .dispatch()
        .await;
}

fn init_sentry() -> ClientInitGuard {
    let dsn = env::var("SENTRY_DSN").unwrap_or_default();
    sentry::init((dsn, sentry::ClientOptions {
        release: sentry::release_name!(),
        ..Default::default()
    }))
}

fn schema() -> UpdateFilterDispatcher<AutoSend<Bot>, Update> {
    // TODO: Реализовать маршрутизацию команд и обработчиков
    Update::filter_message().chain(dptree::endpoint(handlers::message_handler))
}
