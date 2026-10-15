# Spelling Games

Small browser games for practicing spelling, made for my kid.
Live at <https://qbilius.github.io/spelling-games/>

## Games

**Dictation Bee** teaches English spelling to a Lithuanian third grader.
Lithuanian is written as it sounds, so the word list skips words like *dog* or
*seven* and focuses on what is actually hard: letters that do not match the
sound (*mouse*, *friend*, *snow*), double letters (*kitten*, *coffee*), silent
letters (*knife*, *eight*) and digraphs (*thick*, *which*).

Each word goes through two stages. First it is shown and spoken for a few
seconds, then hidden, and the child rebuilds it from its own letters. After
that the word is only spoken, and the letters come mixed with a few decoys.
A word counts as learned after two clean tries; any mistake sends it back to
the first stage. Three words are in play at a time, and a celebration screen
appears after every five learned words. Answering is all tapping, no typing,
since it is meant for a tablet. There is an 8-bit soundtrack generated with
the Web Audio API, and speech comes from the browser's own speech synthesis,
so no audio files are needed.

## How this is built

Every game is one self-contained HTML file in `games/`, with no dependencies
and no build step of its own. It works offline by double-clicking it, and
progress is kept in `localStorage`.

`index.html` is a normal page with a `<!-- GAMES -->` placeholder. On every
push to `main`, a GitHub Actions workflow runs
`.github/scripts/build-index.sh`, a short `sed` script that replaces that
placeholder with one card per game, reading each game's `<title>` and its
optional `description` and `emoji` meta tags. The result is deployed to
GitHub Pages. So adding a game means dropping a file into `games/` and
pushing.

Written with [Claude Code](https://claude.com/claude-code).

## Add a game

```html
<title>Game name</title>
<meta name="description" content="One line about the game">
<meta name="emoji" content="🎮">
```

Games share one origin, so give each its own `localStorage` key prefix
(Dictation Bee uses `bee.`).

## Setup (once)

Repo Settings → Pages → Source: **GitHub Actions**.

## Preview locally

```
bash .github/scripts/build-index.sh
python3 -m http.server -d _site
```
