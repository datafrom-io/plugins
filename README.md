# datafrom-io plugins

Claude Code plugins from [datafrom-io](https://github.com/datafrom-io). This repository is a plugin marketplace named `datafrom`.

## Plugins

| Plugin | What it does |
| --- | --- |
| `video-learning-tutor` | Turns a YouTube video into a guided learning session. Fetches the timestamped transcript through the datafrom YouTube connector, then tutors you with questions and hints instead of ready answers. Installs `datafrom` automatically. |
| `datafrom` | The datafrom.io connectors for Claude Code. Today: the YouTube MCP server (`https://youtube.datafrom.io/mcp`). It has no skills of its own; other plugins depend on it. |

## Install in Claude Code

```
/plugin marketplace add datafrom-io/plugins
/plugin install video-learning-tutor@datafrom
```

Installing `video-learning-tutor` also installs and enables `datafrom`, the plugin that carries the YouTube connector. You do not need to install it separately.

Update later with `/plugin marketplace update datafrom`.

To get only the connector, without the tutor:

```
/plugin install datafrom@datafrom
```

### After installing: sign in to the YouTube connector

The `datafrom` plugin provides the MCP server `https://youtube.datafrom.io/mcp`. It uses OAuth and ships no keys or tokens. Run `/mcp`, pick `plugin:datafrom:youtube` and sign in. Until you do, the tutor cannot fetch transcripts and will offer to sign in or ask you to paste the text.

If you already added the same server yourself (for example with an API key, in user scope), yours takes priority and the plugin's copy is not started. If you also use the YouTube connector in claude.ai, the plugin's server takes priority over it, so sign in once in `/mcp`.

### Upgrading from video-learning-tutor 1.0.0

In 1.0.0 the connector was bundled in the tutor itself, so `/mcp` listed it under the tutor's own name (`plugin:video-learning-tutor:…`). From 2.0.0 it lives in `datafrom` and is called `plugin:datafrom:youtube`. What this means for you:

- Restart Claude Code after `/plugin marketplace update datafrom` and the plugin update: `datafrom` is installed as a dependency on that restart, not by the update itself.
- If `/mcp` still shows no `plugin:datafrom:youtube` after the restart, run `/plugin install datafrom@datafrom`.
- Sign in again: run `/mcp`, pick `plugin:datafrom:youtube` and complete OAuth. The old sign-in does not carry over.
- The tools are now named `mcp__plugin_datafrom_youtube__*`. Permission rules and hooks written for the old tool names (prefix `mcp__plugin_video-learning-tutor_`) no longer match; update them.

### Uninstalling

Removing `video-learning-tutor` leaves `datafrom` installed, because it was installed automatically. To remove such leftovers, run:

```
claude plugin prune
```

### Two copies of the skill

If you also uploaded the skill to claude.ai and your Claude Code syncs claude.ai skills, you will see two copies of `video-learning-tutor`. Remove one of them.

## Use in claude.ai

Every release of a plugin that has a skill, such as `video-learning-tutor`, has a `<plugin>.zip` on the [Releases](../../releases) page. Download `video-learning-tutor.zip` and upload it in claude.ai under Settings, Skills. The YouTube connector is added separately in claude.ai. `datafrom` has no skill, so its releases have no zip and no GitHub Release.

## Releases

A release is a tag named `<plugin>--v<version>`, for example `video-learning-tutor--v2.0.0`. For a plugin with a skill, pushing the tag builds the zip and creates the GitHub Release. For a plugin without a skill, such as `datafrom`, the tag is the whole release.

How a plugin is published depends on whether its source has private development material:

- Plugins whose source repository has such material, like `video-learning-tutor`, are published from that repository by a script, not edited here by hand.
- Plugins without it, like `datafrom`, are edited directly in this repository: change, `claude plugin validate --strict`, commit, `claude plugin tag plugins/<plugin>`, push the branch and the tag.

A plugin that depends on another one is published only after its dependency has a tag here.

## License

MIT, see [LICENSE](LICENSE).
