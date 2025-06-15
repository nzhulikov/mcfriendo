mod commands;
mod handlers;
mod services;
mod db;
mod errors;

use dotenvy::dotenv;
use std::env;
use sentry::ClientInitGuard;
use teloxide::prelude::*;
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

    teloxide::repl(bot, |bot: Bot, msg: Message| async move {
        bot.send_dice(msg.chat.id).await?;
        Ok(())
    })
    .await;
}

fn init_sentry() -> ClientInitGuard {
    let dsn = env::var("SENTRY_DSN").unwrap_or_default();
    sentry::init((dsn, sentry::ClientOptions {
        release: sentry::release_name!(),
        ..Default::default()
    }))
}
