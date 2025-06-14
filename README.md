# McFriendo

AI-ассистент для изучения языков и создания дружбы через языковую практику.

## Цель
Помочь пользователю изучать языки, получать адаптивный контент и трекать прогресс, используя AI-агента (через PicaOS).

## Технологии
- Rust 1.87.0
- teloxide v0.15.0 (webhooks)
- postgres v0.19.10
- sentry v0.39.0
- PicaOS (REST API)
- Supabase (REST API)

## Архитектура
- `main.rs`
- `commands/`
- `handlers/`
- `services/`
- `db/`
- `errors/`

## База данных
- user_profiles (id, chat_id, name, gender, native_lang, target_lang, interests)
- user_progress (id, chat_id, target_lang, topic_id, progress)
- topics (id, title, description, use_case, difficulty [easy, medium, hard], level)
- learning_plans (id, lang, topic_id, next_topic_id)
- exercises (id, chat_id, topic_id, title, type [...], exercise_text, correct_answer, difficulty, accuracy, time, completed)

## Переменные окружения
- BOT_TOKEN
- DATABASE_URL
- SENTRY_DSN
- PICA_API_KEY
- BASE_WEBHOOK_URL 