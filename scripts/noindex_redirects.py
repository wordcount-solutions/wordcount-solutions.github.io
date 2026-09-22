"""Mark Zola-generated staging pagination redirects as non-indexable."""

import sys
from pathlib import Path


def add_noindex(root: Path, base_url: str) -> None:
    if not base_url.rstrip("/").endswith("/staging"):
        return
    for document in root.rglob("*.html"):
        html = document.read_text(encoding="utf-8")
        marker = "<title>Redirect</title>"
        if marker in html and 'name="robots"' not in html:
            document.write_text(
                html.replace(marker, '<meta name="robots" content="noindex, nofollow">\n' + marker, 1),
                encoding="utf-8",
            )


if __name__ == "__main__":
    add_noindex(Path(sys.argv[1]), sys.argv[2])
