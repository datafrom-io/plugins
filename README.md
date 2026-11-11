# datafrom-io plugins

Claude Code plugins from [datafrom-io](https://github.com/datafrom-io). This repository is a plugin marketplace named `datafrom`.

## Plugins

| Plugin | What it does |
| --- | --- |
| `video-learning-tutor` | Turns a YouTube video into a guided learning session. Fetches the timestamped transcript through the bundled YouTube connector, then tutors you with questions and hints instead of ready answers. |

## Install in Claude Code

```
/plugin marketplace add datafrom-io/plugins
/plugin install video-learning-tutor@datafrom
```

Update later with `/plugin marketplace update datafrom`.

### After installing: sign in to the YouTube connector

The plugin bundles the MCP server `https://youtube.datafrom.io/mcp`. It uses OAuth and ships no keys or tokens. Run `/mcp`, pick `datafrom-youtube` and sign in. Until you do, the tutor cannot fetch transcripts and will offer to sign in or ask you to paste the text.

If you already added the same server yourself (for example with an API key, in user scope), yours takes priority and the plugin's copy is not started. If you also use the YouTube connector in claude.ai, the plugin's server takes priority over it, so sign in once in `/mcp`.

### Two copies of the skill

If you also uploaded the skill to claude.ai and your Claude Code syncs claude.ai skills, you will see two copies of `video-learning-tutor`. Remove one of them.

## Use in claude.ai

Every release has a `video-learning-tutor.zip` on the [Releases](../../releases) page. Download it and upload it in claude.ai under Settings, Skills. The YouTube connector is added separately in claude.ai.

## Releases

Plugins are published from their source repositories by a script, not edited here by hand. A release is a tag named `<plugin>--v<version>`, for example `video-learning-tutor--v1.0.0`. Pushing the tag builds the zip and creates the GitHub Release.

## License

MIT, see [LICENSE](LICENSE).
