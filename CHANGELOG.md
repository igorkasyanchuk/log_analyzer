# Changelog

## [Unreleased]

### Added

- **HTML Export with DataTables.js**: Export analysis results to interactive HTML reports
  - Sortable columns
  - Searchable table
  - Pagination support
  - Color-coded performance indicators (green/yellow/orange/red)
  - Responsive design with gradient styling
  - Type badges for Partials (P) and Views (V)
  - Usage: `log_analyzer log/production.log -html`
  - Usage with short paths: `log_analyzer log/production.log -html --short`

### Features

The HTML export provides:

- Interactive table with client-side sorting and searching
- Beautiful gradient UI design
- Color-coded average rendering times:
  - 🟢 Green: < 100ms (good performance)
  - 🟡 Yellow: 100-400ms (moderate)
  - 🟠 Orange: 400-800ms (warning)
  - 🔴 Red: > 800ms (needs optimization)
- Type badges to distinguish Partials vs Views
- Mobile-responsive layout
- Powered by jQuery DataTables

## [0.3.3] - Previous Release
