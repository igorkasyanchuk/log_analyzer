# Contributing to LogAnalyzer

First off, thank you for considering contributing to LogAnalyzer! 🎉

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples** (log files, commands used, etc.)
* **Describe the behavior you observed and what you expected**
* **Include your environment details** (Ruby version, OS, gem version)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Explain why this enhancement would be useful**
* **List some examples of how it would be used**

### Pull Requests

1. **Fork the repository** and create your branch from `master`
2. **Make your changes** following the coding standards below
3. **Add tests** if you've added code that should be tested
4. **Ensure the test suite passes** by running `bundle exec rspec`
5. **Update the documentation** if needed
6. **Add an entry to CHANGELOG.md** describing your changes
7. **Submit a pull request**

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/log_analyzer.git
cd log_analyzer

# Install dependencies
bundle install

# Run tests
bundle exec rspec

# Run the analyzer locally
ruby bin/log_analyzer spec/files/development.log
```

## Coding Standards

* Follow Ruby style conventions
* Write clear, descriptive commit messages
* Add comments for complex logic
* Keep methods focused and concise
* Use meaningful variable and method names

## Testing

* Write RSpec tests for all new features
* Ensure existing tests pass before submitting PR
* Aim for good test coverage
* Test edge cases and error conditions

## Project Structure

```
log_analyzer/
├── bin/                  # Executable scripts
│   └── log_analyzer      # CLI entry point
├── lib/                  # Main library code
│   ├── log_analyzer.rb   # Main module
│   └── log_analyzer/     # Core classes
│       ├── analyzer.rb   # Analysis logic
│       ├── configuration.rb
│       ├── stat.rb       # Statistics calculations
│       ├── utils.rb      # Helper methods
│       └── version.rb
├── spec/                 # Test files
│   ├── files/           # Sample log files for testing
│   └── lib/             # Test specs
└── docs/                # Documentation and assets
```

## Feature Ideas

Looking for something to work on? Check out these ideas:

### High Priority
- [ ] Add percentile calculations (P95, P99)
- [ ] Time-based grouping (analyze by hour/day)
- [ ] Export to JSON format
- [ ] Progress bar for large files

### Medium Priority
- [ ] Controller/action grouping
- [ ] Trend analysis over time
- [ ] Memory usage tracking
- [ ] Database query analysis

### Nice to Have
- [ ] Web UI for viewing reports
- [ ] Real-time monitoring mode
- [ ] Configurable thresholds
- [ ] Multiple log format support

## Questions?

Feel free to open an issue with your question or reach out to the maintainer.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to LogAnalyzer! 🚀
