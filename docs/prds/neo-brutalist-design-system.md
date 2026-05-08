# PRD: Neo-Brutalist Design System Integration

Labels: needs-triage

## Problem Statement

CodeKata currently presents a restrained dark interface built from a mix of Tailwind utilities, `ck-*` component classes, inline styles, and one-off view-level styling. This creates a visual system that is serviceable but inconsistent across the authenticated app shell, dashboard, Challenge browsing, Challenge solving, Collaborative Rooms, Discussion surfaces, Invitations, and Devise screens.

The product direction is to replace the current dark CodeKata theme with a full neo-brutalist visual system: loud, high-contrast, tactile, zine-like, and intentionally maximal while remaining functional for coding workflows. The existing codebase needs this system integrated in a maintainable way, without turning every ERB template into a pile of one-off styles.

## Solution

Replace the global CodeKata theme with a neo-brutalist design system while keeping the existing `ck-*` classes as the stable view-facing styling API. The implementation should centralize design tokens, reskin core primitives, and then apply the system to the app shell and the primary Challenge workflow surfaces.

The first implementation pass should cover global tokens and primitives, the authenticated app shell, the dashboard, Challenge index, Challenge show, and the CodeMirror editor used for Code Evaluation and Collaborative Rooms. The system should use Space Grotesk globally, keep a readable monospace stack for code, and make CodeMirror itself fully neo-brutalist rather than merely wrapping a dark editor in brutalist chrome.

The visual direction should be full zine chaos everywhere, but functional: cream canvas, pure black ink, thick borders, hard offset shadows, high-saturation red/yellow/violet accents, sharp corners, color-blocked sections, sticker-like layering, controlled rotations, texture overlays, bold uppercase typography, and mechanical interactions.

## User Stories

1. As a User, I want CodeKata to have a bold and distinctive visual identity, so that the platform feels memorable rather than generic.
2. As a User, I want the interface to remain functional despite the maximal visual style, so that I can still solve Challenges efficiently.
3. As a User, I want the app shell navigation to clearly show where I am, so that I can move between dashboard, Challenges, Discussions, Friends, and admin areas confidently.
4. As a User, I want the dashboard to use bold stats and clear hierarchy, so that my Challenge Completion progress and Leaderboard context are easy to scan.
5. As a User, I want Challenge cards and lists to feel tactile and clickable, so that browsing Challenges feels responsive.
6. As a User, I want Challenge difficulty and language labels to be visually clear, so that I can choose the right Challenge quickly.
7. As a User, I want search inputs and buttons to have obvious focus and active states, so that keyboard and mouse interaction is predictable.
8. As a User, I want the Challenge show page to separate description, metadata, editor, actions, and test results clearly, so that I can focus on Code Evaluation.
9. As a User, I want CodeMirror to match the neo-brutalist theme, so that the Challenge solving experience feels cohesive.
10. As a User, I want CodeMirror token colors, line numbers, cursor, selections, gutters, and active line treatment to stay readable, so that styling does not interfere with coding.
11. As a User, I want Code Evaluation results to be visually distinct from the editor, so that I can quickly understand pass/fail output.
12. As a User, I want Collaborative Rooms to use the same editor styling as Challenge solving, so that shared coding feels consistent.
13. As a User in a Game, I want editor and result surfaces to remain usable during multi-round competition, so that visual changes do not slow down gameplay.
14. As a User, I want Notifications and flash messages to be obvious and high-contrast, so that important feedback is not missed.
15. As a User, I want text to remain legible on mobile, tablet, and desktop, so that the new style works across devices.
16. As a User using keyboard navigation, I want visible focus states on links, buttons, inputs, and editor-adjacent controls, so that the interface is accessible.
17. As a User with reduced motion preferences, I want nonessential looping or bouncy animations reduced, so that the app remains comfortable.
18. As an Admin, I want admin navigation and controls to inherit the same design system, so that administrative surfaces do not feel disconnected.
19. As an Admin, I want Hint-related actions to remain clearly marked, so that AI Hint functionality is discoverable where enabled.
20. As a developer, I want design tokens centralized, so that palette, fonts, borders, shadows, and patterns can be adjusted without rewriting templates.
21. As a developer, I want the existing `ck-*` class names preserved where practical, so that the design system can be adopted without broad template churn.
22. As a developer, I want inline styles reduced in touched areas, so that future changes are easier and safer.
23. As a developer, I want reusable primitives for buttons, cards, chips, inputs, stat grids, pagination, rich text, toggles, flash messages, and editor surfaces, so that new pages can follow the system consistently.
24. As a developer, I want the app to keep its current Rails, ERB, Tailwind, Stimulus, Turbo, and importmap architecture, so that the integration is idiomatic to the existing stack.
25. As a developer, I want the visual system to avoid additional heavy frontend dependencies, so that the bundle and runtime model remain simple.
26. As a maintainer, I want the first pass scoped to the app shell and core Challenge workflows, so that the design direction can be validated before converting every secondary screen.
27. As a maintainer, I want untouched legacy surfaces to degrade gracefully under global tokens, so that a partial rollout does not produce unusable pages.
28. As a maintainer, I want clear naming for neo-brutalist helpers and tokens, so that future contributors know what belongs to the design system.
29. As a maintainer, I want accessibility preserved or improved, so that the louder style does not reduce usability.
30. As a maintainer, I want visual verification across viewport sizes, so that the zine-like layout does not create overlapping or clipped content.

## Implementation Decisions

- Replace the current dark CodeKata theme globally rather than adding a separate optional theme.
- Keep the existing `ck-*` class names as the stable styling API for views wherever practical.
- Use Space Grotesk from Google Fonts as the global interface font.
- Keep a readable monospace stack for code content, but fully restyle CodeMirror itself in the neo-brutalist system.
- Use the neo-brutalist palette as the canonical token set: cream canvas, pure black ink, hot red accent, vivid yellow secondary, soft violet muted, and white contrast surfaces.
- Make pure black the structural color for borders, text, icon strokes, and hard shadows.
- Replace soft radii with sharp corners by default; reserve fully rounded shapes only for badges, avatars, counters, and intentional sticker motifs.
- Replace soft shadows with hard offset shadows that have no blur.
- Add global texture/pattern utilities for halftone, grid, and paper-like visual density.
- Convert core primitives first: cards, buttons, outline buttons, inputs, chips, stat grids, pagination, flash messages, rich-text/Trix controls, toggles, and editor/result panels.
- Redesign the app shell/sidebar to use thick borders, high-contrast active states, tactile link treatments, and strong brand presence.
- Redesign dashboard surfaces for Challenge Completion, Leaderboard, featured Challenges, and friends using bold cards, color blocking, badges, and controlled chaos.
- Redesign Challenge index around tactile list rows/cards, clear search, high-contrast filters, and strong difficulty chips.
- Redesign Challenge show around Challenge description, metadata, CodeMirror, Code Evaluation action, Hint action where available, and results output.
- Treat CodeMirror as a first-class design-system component: gutter, line numbers, active line, cursor, selections, matching brackets, token colors, scrollbars, and focus state should all be themed.
- Avoid rotating or distorting actual code text, line numbers, form labels, or other precision-reading areas.
- Allow strong rotations, overlaps, badges, and zine-like composition in surrounding layout and decorative elements as long as scanning and interaction remain functional.
- Prefer CSS component classes and Tailwind theme tokens over inline styles in touched surfaces.
- Preserve existing Rails, ERB, Turbo, Stimulus, importmap, and Tailwind architecture.
- Do not introduce a React component library or shadcn-style system.
- Do not introduce heavy animation, icon, or marquee libraries in the first pass.
- Respect `prefers-reduced-motion` for decorative animations and mechanical hover effects.
- Keep all interactive controls semantic and keyboard accessible.
- Ensure mobile layouts stack cleanly and reduce shadow offsets where needed without losing the core aesthetic.

## Testing Decisions

- Tests should verify externally visible behavior and accessibility-relevant outcomes rather than implementation details such as exact utility class strings.
- Existing Challenge solving, Code Evaluation, Collaborative Room, Game, and Navigation behavior should continue to work after the visual refactor.
- Add or update system tests where visual changes touch important workflows: signing in, viewing the dashboard, browsing Challenges, opening a Challenge, submitting code for Code Evaluation, and seeing results.
- Add focused view or system coverage for flash messages, search form behavior, and Challenge list navigation where there is existing test support.
- Use screenshot/manual visual verification for the design-system pass because the main risk is layout regression, overlap, unreadable text, and broken responsive composition.
- Verify desktop and mobile viewports for the app shell, dashboard, Challenge index, and Challenge show.
- Verify keyboard focus visibility for navigation links, buttons, inputs, and editor-adjacent controls.
- Verify reduced-motion behavior manually or with CSS inspection for decorative animations.
- Do not write tests that assert exact colors, rotations, shadows, or font declarations unless a stable helper contract is introduced for them.

## Out of Scope

- Building a new frontend stack or introducing React components.
- Replacing Rails ERB views with a client-side app.
- Adding a user-selectable theme switcher.
- Redesigning every secondary page in the first pass.
- Changing Challenge, Game, Game Round, Score, Discussion, Post, Invitation, Notification, Hint, or AppSetting domain behavior.
- Changing Judge0 or Gemini integrations.
- Changing database schema.
- Reworking authorization, Devise flows, or the hardcoded Admin model.
- Adding major new animation or visual dependency libraries.
- Creating a complete icon system replacement.

## Further Notes

- The design direction is intentionally maximal: full zine chaos everywhere, but functional.
- CodeMirror should not remain dark Monokai; it should be rebuilt visually as a neo-brutalist editor while preserving code readability.
- The first pass should prioritize the surfaces users hit while learning and competing: dashboard, Challenge discovery, Challenge solving, Code Evaluation, and Collaborative Rooms.
- Because many existing views contain inline styles, long-term cleanup should happen incrementally. The first pass should remove inline styling in touched areas and make future pages easier to convert.
- GitHub publishing is blocked until the `gh` CLI is re-authenticated for the repository owner account.
