#!/usr/bin/env bash
# Проверяет релизный тег <plugin>--v<version> и собирает <plugin>.zip для claude.ai.
# Использование: build-skill-zip.sh <тег> [папка вывода]
# В архиве ровно один файл: <plugin>/SKILL.md, побайтно равный файлу в тегe.
set -euo pipefail

TAG="${1:?usage: build-skill-zip.sh <tag> [out-dir]}"
OUT="${2:-.}"

case "$TAG" in
  *--v*) ;;
  *) echo "ERROR: тег $TAG не соответствует <plugin>--v<version>" >&2; exit 1 ;;
esac
PLUGIN="${TAG%%--v*}"
VERSION="${TAG##*--v}"
DIR="plugins/${PLUGIN}"
SKILL="${DIR}/skills/${PLUGIN}/SKILL.md"

[ -f "$SKILL" ] || { echo "ERROR: нет файла $SKILL" >&2; exit 1; }
[ -f "${DIR}/.claude-plugin/plugin.json" ] || { echo "ERROR: нет ${DIR}/.claude-plugin/plugin.json" >&2; exit 1; }

python3 -I - "$DIR/.claude-plugin/plugin.json" "$PLUGIN" "$VERSION" "$SKILL" <<'PY'
import json, re, sys
manifest, plugin, version, skill = sys.argv[1:5]
m = json.load(open(manifest, encoding="utf-8"))
if m.get("name") != plugin:
    sys.exit(f"ERROR: name в plugin.json ({m.get('name')!r}) не равен {plugin!r}")
if m.get("version") != version:
    sys.exit(f"ERROR: version в plugin.json ({m.get('version')!r}) не равна версии тега {version!r}")
lines = open(skill, encoding="utf-8").read().splitlines()
if not lines or lines[0].strip() != "---":
    sys.exit("ERROR: SKILL.md без frontmatter")
end = next((i for i in range(1, len(lines)) if lines[i].strip() == "---"), None)
if end is None:
    sys.exit("ERROR: frontmatter не закрыт")
fm = {}
for l in lines[1:end]:
    mt = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", l)
    if mt:
        fm[mt.group(1)] = mt.group(2).strip().strip("\"'")
name, desc = fm.get("name", ""), fm.get("description", "")
if not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name) or len(name) > 64:
    sys.exit(f"ERROR: name {name!r} не kebab-case или длиннее 64 символов")
if not desc or len(desc) > 1024 or "<" in desc or ">" in desc:
    sys.exit("ERROR: description пуст, длиннее 1024 символов или содержит < >")
PY

mkdir -p "$OUT"
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/skillzip.XXXXXX")"
trap 'rm -rf "$STAGE"' EXIT
mkdir -p "${STAGE}/${PLUGIN}"
cp "$SKILL" "${STAGE}/${PLUGIN}/SKILL.md"
ZIP="$(cd "$OUT" && pwd)/${PLUGIN}.zip"
rm -f "$ZIP"
( cd "$STAGE" && zip -q -X -D -r "$ZIP" "$PLUGIN" )

LISTED="$(unzip -Z1 "$ZIP" | grep -v '/$' || true)"
[ "$LISTED" = "${PLUGIN}/SKILL.md" ] || { echo "ERROR: неожиданный состав архива: $LISTED" >&2; exit 1; }
unzip -p "$ZIP" "${PLUGIN}/SKILL.md" | cmp -s - "$SKILL" || { echo "ERROR: SKILL.md в архиве отличается от исходного" >&2; exit 1; }
echo "OK: $ZIP"
