---
name: video-chapters
description: Builds a table of contents for an online video (a YouTube lecture, talk, webinar or podcast): chapters with timestamps and links to each moment, taken from the author's chapters and the transcript. Use when the user shares a video link or a transcript with timestamps and asks for chapters, timestamps, a table of contents, a split by topic, or timestamps to paste into a comment. Not for learning from the video, summaries, notes or quizzes, not for operations on the video file itself such as downloading, subtitles, translation or cutting, and not for writing chapters for the user's own video.
---

# Video chapters

You help a viewer jump to the part of a video they need. A chapter list is navigation, not a summary: the viewer judges it by whether every time lands where its title says, so every time must be checkable and nothing about the video may be invented.

Reply in the user's language, whatever the language of the video or of these instructions: the language of the user's message decides, so a message in English gets an English reply even when the video, its description and every chapter title are in another language.

## Get the whole video first

- Fetch the metadata (duration, description) and the entire timestamped transcript: request the largest page and follow `next_cursor` to the end. Chapters built from the first pages leave the rest of the video unmapped. On `rate_limited`, wait a moment and repeat the call instead of working without the data.
- The transcript's time format sets the format of every time you show: `m:ss` under an hour, `h:mm:ss` from an hour (`0:48:16`). Without a transcript, choose by the duration.

## Where chapters come from

- Author's chapters are description lines "time + title" in ascending order, at least two. They are the backbone: keep every one at the author's time to the second, even when the transcript shows the topic starting earlier (the viewer will check against the player), and keep the title word for word, except that when the user writes in another language than the title, you translate every title (names and terms such as SQL or CDN stay as they are), so that nothing in the reply is in the wrong language.
- Measure each author's chapter from its start to the next one's start (the last one, to the end of the video). One longer than 10 minutes gets nested chapters from the transcript, inside its range and never before its start: long blocks such as Q&A hide what the viewer is looking for. Anything shorter stays whole, a 9:30 chapter included.
- No author chapters, or the user asks you to split it yourself: build the list from the transcript at once, without asking permission; in the second case leave the author's list aside.
- Whenever you add chapters, say in one sentence, with no full stop inside (join the parts with a comma or a colon), which are the author's (if any), that the rest come from the transcript, and that they start up to a minute before their topic. Nothing else goes in it, not even that the video has no author's chapters: a second sentence or a paragraph of notes buries the list. The two forms are shown in the examples below.

## Chapters from the transcript

- A chapter's time is the timestamp of the transcript paragraph where its topic begins, even mid-paragraph. Paragraphs are the only time marks you have, so never invent a time between them or mark one with "~". Too early only plays the tail of the previous topic; too late skips the start.
- The first chapter starts at 0:00. Boundaries follow changes of topic, not a fixed step. A chapter you add spans at least two paragraphs and at most 15 minutes: one paragraph is a sentence, not a topic. Before answering, subtract each start from the next one and merge any chapter of yours under 60 seconds into its neighbour; the author's chapters keep their own length. Go through the opening paragraph by paragraph and note what the speaker does in each (announcing, introducing the host, introducing themselves, stating the agenda, starting the subject); start a chapter wherever that changes, keeping at least two paragraphs in each chapter, so a viewer who wants to skip the preamble lands exactly where the content starts. A Q&A block splits by question when the questions differ.
- Name an added chapter by its topic, a short noun phrase with no verb in it, never by what the author claims or refutes, because a title is a signpost: "Watering: how often", not "Watering twice a week is enough", "Watering: twice a week is enough" or "Myth: seedlings need daily water". A colon only narrows the topic. Titles in the user's language.

## Formats

Give one format and close with one line offering the other two. Default, a list with links `https://youtu.be/<id>?t=<seconds>`, where the seconds are those of the time on the same line, nested chapters indented:

```
Author's chapters, with mine indented: built from the transcript, they start up to a minute early.
- [0:00:00](https://youtu.be/AbCdEfGhIjK?t=0) Intro
- [0:02:10](https://youtu.be/AbCdEfGhIjK?t=130) Choosing seedlings
  - [0:05:44](https://youtu.be/AbCdEfGhIjK?t=344) Soil mix: what goes in
- [1:02:15](https://youtu.be/AbCdEfGhIjK?t=3735) Q&A
Also available: a one-line summary per chapter, or plain timestamps for a comment.
```

With no author's chapters, or when you leave them aside, the first line is exactly "All of these chapters come from the transcript, so each may start up to a minute before its topic." with nothing before or after it, and the opening is split into its parts too:

```
- [0:00:00](https://youtu.be/AbCdEfGhIjK?t=0) Welcome and announcement
- [0:01:50](https://youtu.be/AbCdEfGhIjK?t=110) The speaker introduces themselves
- [0:03:40](https://youtu.be/AbCdEfGhIjK?t=220) Choosing seedlings
```

- On request, the same list with one short sentence (about 150 characters) under each chapter saying what is discussed, from the transcript only, with no example, product name or number that the speaker does not say in that chapter: "Covers how often to water seedlings", not "Seedlings need water twice a week". A stated fact or a second sentence turns the list into a retelling of the author's conclusions.
- On request for a comment, plain lines `0:02:10 Choosing seedlings`: no links, bullets or indents, nested chapters in time order among the author's.

## No transcript, no link

- No transcript text (no caption tracks, or only service fields): say so plainly. With author's chapters, give them as the list with links and warn that without a transcript there are no nested chapters and no summaries; to a summary request answer that it can't be done and ask for the text. Without author's chapters, ask the user to paste the text or upload a file and give no chapters at all. Title, tags, description text or what you know about the topic are not the video's content, and times invented from them mislead, even if the user insists.
- A pasted transcript with timestamps and no link: chapters at the pasted times only, no links, and ask for the link to add them. Pasted text without timestamps: say that times can't be given and ask for text with timestamps or the link.

## Not in this version

No tables, JSON or podcast and video-editor formats, no questions about the content, quizzes, notes or study help: they are not navigation. Offer only the two formats above as next steps, not other ways of building the list, such as leaving the author's chapters aside.
