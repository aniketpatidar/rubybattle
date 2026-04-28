# CodeKata — Domain Context

CodeKata is a competitive code-learning platform where developers sharpen their Ruby skills through challenges, head-to-head duels, collaborative pair-programming, and a community discussion forum.

---

## Core Loop

The platform has two primary loops:

- **Competitive loop**: User → Challenge → Duel — a user finds a coding challenge and races a friend to solve it first
- **Social loop**: User → Discussion → Post — a user asks questions or shares solutions in the forum, voted on by the community

---

## Glossary

### Challenge
A Ruby coding problem with a difficulty tier (easy / medium / hard), a set of test cases, and a method template the solver must implement. Challenges are the unit of competition in Duels and the unit of completion in a user's profile.

- Avoid: "problem", "exercise", "kata" (reserved for the brand, not a model term)

### Duel
A timed, head-to-head competition between two users on the same Challenge. The first participant to pass all test cases wins. A Duel moves through three statuses: `pending` (invited, not yet started) → `active` (both players coding) → `completed` (winner determined).

- **Challenger**: the user who initiates the Duel
- **Opponent**: the user who accepts the Duel invitation
- **Winner**: the User who completes the Challenge first (nullable until Duel is completed)
- Avoid: "game", "match", "race" — use "Duel"

### Challenge Completion
A record that a specific User has passed all tests for a specific Challenge. Unique per user per challenge — completing a Challenge twice does not create two records.

### Code Evaluation
The act of submitting code to Judge0 for test execution. Triggered from the editor; results are streamed back in real time. A successful evaluation on all test cases triggers a Challenge Completion and may resolve a Duel.

### Collaborative Room
A shared real-time code editor session for a given Challenge, identified by a `room_id`. Multiple users can edit simultaneously via ActionCable. Distinct from a Duel — no winner, no timer.

- Avoid: "collaboration session", "pair room" — use "Collaborative Room" or just "Room"

### Discussion
A forum thread with a title, a rich-text body, and zero or more Categories. Discussions are votable (upvote / downvote) and can be pinned or closed by admins. Vote count = upvotes − downvotes.

- Avoid: "thread", "topic", "question" — use "Discussion"

### Post
A reply inside a Discussion. Has a rich-text body. Counter-cached on the parent Discussion.

- Avoid: "comment", "reply", "answer" — use "Post"

### Category
A tag that classifies a Discussion (e.g. "Ruby", "Algorithms"). Many-to-many with Discussion.

### Invitation
A friend request from one User to another. Becomes a confirmed friendship once accepted. Friendship is bidirectional — confirmed on either side counts.

- `pending`: sent, not yet accepted
- `confirmed`: accepted, both users are friends
- Avoid: "friend request", "connection" — use "Invitation"

### Notification
An in-app alert delivered to a User. Uses STI for typed notifications (duel invites, duel results, discussion replies, etc.). Unread = `read_at` is nil.

### Hint
An AI-generated 2–3 sentence nudge for a Challenge, produced by Gemini given the challenge description and the user's current code. Gated by the `ai_hints_enabled` AppSetting.

### AppSetting
A key/value feature flag managed by admins. Currently controls `ai_hints_enabled`. Boolean value.

---

## User Identity

- **Slug**: a unique, URL-safe username auto-generated from the user's full name. Used in profile URLs (`/users/:slug`) and as the primary public identifier.
- **Admin**: `User#id == 1` is hardcoded as the admin. No role table.
- **Online presence**: tracked via Kredis; broadcast over `OnlineChannel`.

---

## Enums

| Model | Field | Values |
|-------|-------|--------|
| Challenge | `difficulty` | `easy`, `medium`, `hard` |
| Duel | `status` | `pending`, `active`, `completed` |

---

## External Services

- **Judge0** — sandboxed code execution API. Wraps submitted Ruby code around each test case, polls for results.
- **Gemini** — AI hint generation (Gemini 2.0 Flash). Requires `GEMINI_API_KEY`.

---

## What this glossary is for

Use these terms exactly when naming issues, test descriptions, refactor proposals, and PR titles. If a concept you need isn't here, don't invent a synonym — either use the nearest term or flag the gap.
