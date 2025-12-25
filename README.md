# WordCount Solutions Website

This is the source code for the WordCount Solutions website, built with [Zola](https://www.getzola.org/), a static site generator written in Rust.

## Project Structure

```
wordcount-website/
├── config.toml              # Main Zola configuration
├── content/                 # Content files (markdown)
│   ├── _index.md           # Homepage content
│   ├── team/               # Team member profiles
│   │   ├── _index.md       # Team section index
│   │   └── *.md            # Individual team member files
│   ├── testimonials/       # Client testimonials
│   ├── posts/              # Blog posts
│   └── projects/           # Project portfolio
├── static/                 # Static assets (copied to public/ during build)
│   └── images/
│       └── team/           # Team member photos
│           └── *.jpeg      # Team photos (Firstname-Lastname.jpeg format)
├── templates/              # Custom templates (override theme templates)
│   ├── index.html          # Homepage template
│   └── components/         # Custom component templates
│       ├── index.html      # Component router
│       └── team-section.html # Team section component
├── themes/                 # Zola theme
│   └── vonge/              # Vonge theme files
└── public/                 # Generated site (output directory - do not edit)
```

## Prerequisites

You need to have [Zola](https://www.getzola.org/) installed on your system.

### Installing Zola

**macOS (using Homebrew):**
```bash
brew install zola
```

**Linux:**
```bash
# Download from https://github.com/getzola/zola/releases
# Or use your distribution's package manager
```

**Windows:**
Download the executable from [Zola releases](https://github.com/getzola/zola/releases)

## Building and Serving the Site

### Serve Locally (Development)
```bash
zola serve
```

This will start a local development server at `http://127.0.0.1:1111` that auto-reloads when you make changes.

### Build for Production
```bash
zola build
```

This generates the static site in the `public/` directory.

## Editing Content

### Homepage

**File**: `config.toml`

The homepage content is configured in `config.toml` under `[extra.content_blocks]`. The main hero section includes:
- **Title**: "Human-Centered Technical Writing and Editing — On Demand"
- **Description**: The main tagline/description
- **Team Section**: Displays team members from `content/team/`

To modify the homepage content, edit the `[[extra.content_blocks]]` sections in `config.toml`. Each block has different properties:
- `block = "hero"`: Main hero section with title, description, and image
- `block = "team-section"`: Team member carousel section

### Team Page

**File**: `content/team-page.md`

The Team page displays all team members in a dedicated page. To edit:
1. Open `content/team-page.md`
2. Modify the `title` and `description` in the `page-heading` block
3. The team members are automatically loaded from `content/team/` directory

The page uses content blocks:
- `page-heading`: Page title and description
- `team-section`: Displays all team members
- `newsletter`: Newsletter subscription form

### Philosophy Page

**File**: `content/philosophy.md`

The Philosophy page (formerly Elements) contains your company philosophy and values. To edit:
1. Open `content/philosophy.md`
2. Modify the `title` in the front matter (currently "Philosophy")
3. Edit the `content_html` field in the `content` block to change the page content
4. You can use HTML tags in the `content_html` field for formatting

**Content Block Structure:**
- `page-heading`: Page title
- `page-image`: Optional header image
- `content`: Main page content (HTML)
- `newsletter`: Newsletter subscription form

### About Page

**File**: `content/about.md`

The About page contains information about WordCount Solutions. To edit:
1. Open `content/about.md`
2. Modify the `title` in the front matter
3. Edit the `content_html` field in the `content` block
4. Optionally change the `page-image` block to use a different header image

**Content Block Structure:**
- `page-heading`: Page title
- `page-image`: Optional header image
- `content`: Main page content (HTML)
- `newsletter`: Newsletter subscription form

### Team Members

Team members are displayed in a dedicated "WordCount Team" section on the homepage. Each team member requires:

1. **Photo**: Place team member photos in `static/images/team/` with the naming format:
   - `Firstname-Lastname.jpeg` (e.g., `John-Smith.jpeg`)
   - Use capital letters for the first letter of each name
   - Use hyphens to separate first and last names

2. **Content File**: Create a markdown file in `content/team/` with the same naming pattern:
   - `content/team/Firstname-Lastname.md`

3. **File Structure**: Each team member file should follow this format:

```toml
+++
[extra]
name = "Firstname Lastname"
position = "One sentence description of what they do"
image = "/images/team/Firstname-Lastname.jpeg"
blurb = ""
+++
```

**Fields:**
- `name`: Full name as it should appear on the website
- `position`: One sentence description of their role/responsibilities (appears under the photo)
- `image`: Path to the photo (must match the filename in `static/images/team/`)
- `blurb`: Leave empty (reserved for longer quotes/testimonials)

**Example:**
```toml
+++
[extra]
name = "John Smith"
position = "Senior Technical Writer specializing in API documentation"
image = "/images/team/John-Smith.jpeg"
blurb = ""
+++
```

### Adding a New Team Member

1. Add the photo to `static/images/team/Firstname-Lastname.jpeg`
2. Create `content/team/Firstname-Lastname.md` with the structure above
3. Fill in the `name` and `position` fields
4. The site will automatically rebuild and display the new team member

### Testimonials

Client testimonials are stored in `content/testimonials/`. Each testimonial file follows a similar structure to team members but includes a `blurb` field for the testimonial text.

**Testimonial File Format:**
```toml
+++
[extra]
name = "Client Name"
position = "Client Title/Company"
image = "/images/client-X.jpg"
blurb = "The testimonial text goes here."
+++
```

### Navigation

**File**: `config.toml`

The site navigation is configured in `config.toml` under `[extra.navigation]`. The current navigation includes:
- **Home**: Links to the homepage
- **Team**: Links to the team page (`/team-page`)
- **Pages** (dropdown):
  - **About**: Links to the about page
  - **Philosophy**: Links to the philosophy page

To modify navigation, edit the `navigation` array in `config.toml`. Each item can have:
- `url`: The page URL (use `$BASE_URL` for the site's base URL)
- `title`: The link text
- `submenu`: Optional array of submenu items

**Note**: Projects, Blog, and Tags sections are hidden from navigation but can be enabled by setting `show_projects = true`, `show_blog = true`, or `show_tags = true` in `config.toml` and adding them back to the navigation array.

## Static Assets

All files in `static/` are copied directly to `public/` during the build process, preserving the directory structure.

- **Team Photos**: `static/images/team/` → `public/images/team/`
- **Other Images**: `static/images/` → `public/images/`
- **CSS/JS**: Place in `static/css/` or `static/js/` as needed

## Configuration

### Main Configuration (`config.toml`)

The main site configuration is in `config.toml` at the root. Key sections:

- `[extra.content_blocks]`: Defines homepage sections (hero, team-section, etc.)
- `[extra.navigation]`: Site navigation menu configuration
- `[extra.newsletter]`: Newsletter subscription configuration
- `show_projects`, `show_blog`, `show_tags`: Boolean flags to control section visibility (currently all set to `false`)
- `title`, `description`, `base_url`: Site metadata

### Theme

This site uses the **Vonge** theme (located in `themes/vonge/`) as its base. The theme provides:
- Homepage layout with content blocks
- Team/testimonials display components
- Blog and project templates
- Responsive design

**Note**: Do not modify files in `themes/vonge/` directly. Instead, override them by creating files in `templates/` at the root level.

## Custom Templates

Custom templates that override the theme are in `templates/`:

- `templates/index.html`: Homepage template
- `templates/components/team-section.html`: Custom team section component
- `templates/components/index.html`: Component router (adds team-section support)

## Troubleshooting

### Images Not Appearing
- Ensure images are in `static/images/team/` (not `public/`)
- Check that image paths in markdown files match the actual filenames
- Verify filenames match exactly (case-sensitive)
- Hard refresh browser: `Cmd+Shift+R` (Mac) or `Ctrl+Shift+R` (Windows/Linux)

### Changes Not Showing
- Restart `zola serve` if it's running
- Clear browser cache
- Check for build errors in the terminal

### Build Errors
- Verify TOML syntax in `config.toml` and content files
- Check that all referenced images exist
- Ensure markdown front matter is properly formatted

## Deployment

The site is a static site that can be deployed to any static hosting service:

1. Build the site: `zola build`
2. Upload the contents of `public/` to your web server

The `public/` directory contains the complete static website ready for deployment.

## Quick Reference

| Task | Location |
|------|----------|
| Edit homepage content | `config.toml` |
| Edit Team page | `content/team-page.md` |
| Edit Philosophy page | `content/philosophy.md` |
| Edit About page | `content/about.md` |
| Add team member | `content/team/Firstname-Lastname.md` + `static/images/team/Firstname-Lastname.jpeg` |
| Add testimonial | `content/testimonials/Client-Name.md` |
| Modify navigation | `config.toml` → `[extra.navigation]` |
| Team photos | `static/images/team/` |
| Other images | `static/images/` |

## Support

For Zola documentation, visit: https://www.getzola.org/documentation/

For theme-specific questions, see: `themes/vonge/README.md`

