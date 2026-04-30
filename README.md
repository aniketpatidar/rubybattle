# CodeKata

A competitive coding platform for Ruby developers. Solve challenges, compete in multi-round games against friends, collaborate in real-time, and discuss solutions in the community forum.

## Stack

- Ruby on Rails 7, PostgreSQL, Redis
- Hotwire (Turbo + Stimulus), ActionCable
- CodeMirror 6, Judge0, Tailwind CSS

## Setup

**Requirements:** Ruby 3.2.2, PostgreSQL, Redis, Node.js

```bash
git clone https://github.com/aniketpatidar/codekata
cd codekata
bundle install
yarn install
cp .env.example .env
rails db:create db:migrate db:seed
bin/dev
```

Open `http://localhost:3000`.

## License

MIT
