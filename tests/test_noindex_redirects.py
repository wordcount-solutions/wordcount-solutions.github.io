"""Confirm staging-only treatment of Zola pagination redirects."""

import tempfile
import unittest
from pathlib import Path

from scripts.noindex_redirects import add_noindex


class RedirectIndexingTests(unittest.TestCase):
    def test_staging_redirect_is_marked_once(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            page = Path(directory) / "index.html"
            page.write_text("<title>Redirect</title><a href='/staging/posts/'>Posts</a>")
            add_noindex(Path(directory), "https://wordcount-solutions.github.io")
            self.assertNotIn("noindex", page.read_text())
            add_noindex(Path(directory), "https://wordcount-solutions.github.io/staging")
            add_noindex(Path(directory), "https://wordcount-solutions.github.io/staging")
            self.assertEqual(page.read_text().count('name="robots"'), 1)
