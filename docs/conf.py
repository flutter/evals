# Configuration file for the Sphinx documentation builder.
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import sys

# Add the source directory to the path so Sphinx can find the modules
sys.path.insert(0, os.path.abspath("../packages/dash_evals/src"))

# -- Project information -----------------------------------------------------

project = "dash_evals"
copyright = "2025, Flutter Authors"
author = "Flutter Authors"

# -- General configuration ---------------------------------------------------

extensions = [
    "sphinx.ext.autodoc",  # Auto-generate docs from docstrings
    "sphinx.ext.napoleon",  # Support Google/NumPy docstring styles
    "sphinx.ext.viewcode",  # Add links to source code
    "sphinx.ext.intersphinx",  # Link to other projects' docs
    "sphinx_autodoc_typehints",  # Better type hint rendering
    "myst_parser",  # Support Markdown files
    "sphinx_design",  # Cards, grids, tabs
]

# Autodoc settings
autodoc_default_options = {
    "members": True,
    "member-order": "bysource",
    "special-members": "__init__",
    "undoc-members": True,
    "exclude-members": "__weakref__",
}
autodoc_typehints = "description"
autodoc_class_signature = "separated"

# Napoleon settings (for Google-style docstrings)
napoleon_google_docstring = True
napoleon_numpy_docstring = True
napoleon_include_init_with_doc = True
napoleon_include_private_with_doc = False

# MyST parser settings (for Markdown support)
myst_enable_extensions = [
    "colon_fence",
    "fieldlist",
]

# Intersphinx mapping
intersphinx_mapping = {
    "python": ("https://docs.python.org/3", None),
}

# -- Options for HTML output -------------------------------------------------

html_theme = "pydata_sphinx_theme"
html_title = "evals"
root_doc = "index"

html_theme_options = {
    # # Logo
    # "logo": {
    #     "image_light": "_static/images/logo.png",
    #     "image_dark": "_static/images/logo.png",
    # },
    # Show all top-nav tabs instead of collapsing to "More ▾"
    "header_links_before_dropdown": 4,
    # Top-right icons
    "icon_links": [
        {
            "name": "GitHub",
            "url": "https://github.com/flutter/evals",
            "icon": "fa-brands fa-github",
        },
    ],
    # --- Header / Navigation Bar ---
    # Left: logo
    "navbar_start": ["navbar-logo"],
    # Center: top-level section tabs (Guides, Reference, Contributing)
    # These are auto-generated from root-level toctree entries in index.md.
    "navbar_center": ["navbar-nav"],
    # Right: theme switcher + icon links
    "navbar_end": ["theme-switcher", "navbar-icon-links"],
    # Persistent right (stays visible even on small screens)
    "navbar_persistent": ["search-button"],
    # Align nav tabs to the left, closer to the logo
    "navbar_align": "left",
    # --- Primary sidebar (left) ---
    # Show 2 levels of nav expanded by default
    "show_nav_level": 1,
    # --- Secondary sidebar (right) ---
    # Shows the current page's table of contents
    "secondary_sidebar_items": ["page-toc"],
    # --- Syntax highlighting ---
    "pygments_light_style": "xcode",
    "pygments_dark_style": "monokai",
}

# --- Primary sidebar (left) ---
# Shows section sub-navigation (e.g. Guides subpages) via sidebar-nav-bs.
# This is the correct way to configure the left sidebar in PyData theme.
# Use page-glob patterns to customise per-section, e.g. {"index": []} to hide.
html_sidebars = {
    "**": ["sidebar-nav-bs"],
}

# Static files
html_static_path = ["_static"]
html_css_files = ["custom.css"]

# Source file suffixes
source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}
