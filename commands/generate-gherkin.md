---
description: Convert user stories with acceptance criteria into Gherkin Feature files for BDD test automation (Cucumber, SpecFlow, Behave)
argument-hint: [story-id or @story-file] [framework]
allowed-tools: Read, Write, mcp__azure-devops__*
model: claude-sonnet-4-5-20250929
---

# Generate Gherkin - BDD Feature File Generator

Convert user stories into properly formatted Gherkin Feature files for test automation.

## What This Does

1. **Reads the story** from Azure DevOps or file ($1)
2. **Extracts acceptance criteria** (Given-When-Then format)
3. **Generates Gherkin Feature file** with:
   - Feature description
   - Background (common setup)
   - Scenarios (from acceptance criteria)
   - Scenario Outlines (data-driven tests)
   - Examples tables
   - Appropriate tags
4. **Creates step definitions** (optional, $2)
5. **Organizes test structure** by feature area
6. **Outputs .feature file** ready for automation

## Usage

### From Azure DevOps Story
```
/generate-gherkin 12345
```

### From File
```
/generate-gherkin @stories/date-filter-story.md
```

### With Framework Specification
```
/generate-gherkin 12345 cucumber
/generate-gherkin 12345 specflow
/generate-gherkin 12345 behave
```

### With Step Definitions
```
/generate-gherkin 12345 cucumber --with-steps
```

## Input Requirements

### Story Must Have:
- Clear title/description
- Acceptance criteria in Given-When-Then format
- User persona (As a...)
- Goal (I want to...)
- Benefit (So that...)

### Example Story:

```markdown
## Story: Date Range Filtering for Order History

**As an** operations manager
**I want to** filter order history by date range
**So that** I can quickly find orders from specific periods

### Story Points: 5

### Acceptance Criteria

#### AC1: User can select date range
**Given** I am on the order history page
**When** I click the "Filter by Date" button
**Then** I see a date range picker

#### AC2: Filter applies successfully
**Given** I have selected dates (Jan 1 - Jan 31)
**When** I click "Apply Filter"
**Then** Only orders from January are displayed
**And** Order count updates

#### AC3: Invalid date prevented
**Given** I am selecting a date range
**When** I select "To" date before "From" date
**Then** I see error "End date must be after start date"
**And** "Apply Filter" button is disabled
```

## Output

### Generated Feature File

`features/order-management/date-range-filtering.feature`:

```gherkin
@order-history @filtering @sprint-42
Feature: Date Range Filtering for Order History
  As an operations manager
  I want to filter order history by selecting a date range
  So that I can quickly find orders from specific time periods

  Background:
    Given I am logged in as an operations manager
    And I am on the order history page
    And there are orders from multiple months

  @smoke @critical @AC1
  Scenario: User can select date range
    When I click the "Filter by Date" button
    Then I see a date range picker with "From" and "To" fields
    And today's date is pre-selected

  @happy-path @AC2
  Scenario: Filter applies successfully
    Given the date picker is displayed
    When I select date range from "2025-01-01" to "2025-01-31"
    And I click "Apply Filter"
    Then only orders from January 2025 are displayed
    And the order count shows filtered results
    And the URL includes filter parameters

  @validation @negative @AC3
  Scenario: Invalid date range is prevented
    Given the date picker is displayed
    When I select "To" date as "2025-01-01"
    And I select "From" date as "2025-01-31"
    Then I see error message "End date must be after start date"
    And the "Apply Filter" button is disabled
    And no filter is applied

  @data-driven
  Scenario Outline: Filter with various date ranges
    When I apply filter from "<from_date>" to "<to_date>"
    Then I see exactly "<order_count>" orders
    And the filter displays as "<display_text>"

    Examples:
      | from_date  | to_date    | order_count | display_text  |
      | 2025-01-01 | 2025-01-07 | 12         | Last 7 days   |
      | 2025-01-01 | 2025-01-31 | 45         | January 2025  |
      | 2024-12-01 | 2025-01-31 | 103        | Last 2 months |

  @accessibility @wcag-aa
  Scenario: Keyboard navigation works
    When I navigate to date filter using Tab key
    And I interact using keyboard only
    Then I can select dates and apply filter
    And screen reader announces filter results

  @performance
  Scenario: Filter performs efficiently
    Given there are 10,000 orders in the system
    When I apply a date filter
    Then the results appear within 200 milliseconds
    And the UI remains responsive
```

## Framework-Specific Output

### Cucumber (JavaScript/Ruby/Java)

```gherkin
Feature: Date Range Filtering

  @javascript @selenium
  Scenario: Filter by date
    Given I navigate to the order history page
    When I select daterange "2025-01-01" to "2025-01-31"
    Then I should see 45 order items
    And the URL should include "from=2025-01-01"
```

**Step Definitions (JavaScript):**
```javascript
// features/step_definitions/filtering.steps.js
const { Given, When, Then } = require('@cucumber/cucumber');

Given('I navigate to the order history page', async function() {
  await this.page.goto('/orders');
});

When('I select daterange {string} to {string}', async function(from, to) {
  await this.page.fill('[data-testid="date-from"]', from);
  await this.page.fill('[data-testid="date-to"]', to);
  await this.page.click('[data-testid="apply-filter"]');
});

Then('I should see {int} order items', async function(count) {
  const items = await this.page.locator('.order-item').count();
  expect(items).toBe(count);
});
```

### SpecFlow (.NET/C#)

```gherkin
@WebTest @OrderManagement
Feature: Date Range Filtering
  In order to find specific orders
  As an operations manager
  I want to filter orders by date range

  Scenario: Apply date filter
    Given I have navigated to the order history page
    When I filter by date range "01/01/2025" to "01/31/2025"
    Then the order list should contain 45 items
    And the filter indicator should show "January 2025"
```

**Step Definitions (C#):**
```csharp
// Steps/FilteringSteps.cs
[Binding]
public class FilteringSteps
{
    private readonly IWebDriver _driver;

    [Given(@"I have navigated to the order history page")]
    public void GivenNavigatedToOrderHistory()
    {
        _driver.Navigate().GoToUrl("/orders");
    }

    [When(@"I filter by date range ""(.*)"" to ""(.*)""")]
    public void WhenFilterByDateRange(string from, string to)
    {
        _driver.FindElement(By.Id("dateFrom")).SendKeys(from);
        _driver.FindElement(By.Id("dateTo")).SendKeys(to);
        _driver.FindElement(By.Id("applyFilter")).Click();
    }

    [Then(@"the order list should contain (\d+) items")]
    public void ThenOrderListShouldContainItems(int expectedCount)
    {
        var items = _driver.FindElements(By.ClassName("order-item"));
        Assert.AreEqual(expectedCount, items.Count);
    }
}
```

### Behave (Python)

```gherkin
@order-filtering @selenium
Feature: Date Range Filtering

  Scenario: Filter orders by date
    Given the order history page is loaded
    When I apply date filter from "2025-01-01" to "2025-01-31"
    Then exactly 45 orders should be visible
    And the status bar shows "Showing 45 of 1,234 orders"
```

**Step Definitions (Python):**
```python
# features/steps/filtering_steps.py
from behave import given, when, then

@given('the order history page is loaded')
def step_load_order_history(context):
    context.browser.get('http://localhost:3000/orders')
    assert "Order History" in context.browser.title

@when('I apply date filter from "{from_date}" to "{to_date}"')
def step_apply_date_filter(context, from_date, to_date):
    context.browser.find_element_by_id('date-from').send_keys(from_date)
    context.browser.find_element_by_id('date-to').send_keys(to_date)
    context.browser.find_element_by_id('apply-filter').click()

@then('exactly {count:d} orders should be visible')
def step_verify_order_count(context, count):
    orders = context.browser.find_elements_by_class_name('order-item')
    assert len(orders) == count, f"Expected {count}, found {len(orders)}"
```

## Directory Structure Created

```
features/
├── order-management/
│   └── date-range-filtering.feature
├── step_definitions/           # Cucumber/Behave
│   └── filtering_steps.js
├── Steps/                      # SpecFlow
│   └── FilteringSteps.cs
└── support/
    ├── world.js               # Shared context
    └── hooks.js               # Before/After hooks
```

## Tags Generated

I automatically add relevant tags:

```gherkin
@order-history        # Feature area
@filtering           # Capability
@sprint-42           # Sprint number (from ADO)
@smoke              # Critical path
@regression         # Full test suite
@happy-path         # Positive scenarios
@negative           # Error/validation scenarios
@data-driven        # Scenario Outlines
@accessibility      # WCAG tests
@performance        # Performance tests
@AC1, @AC2, @AC3    # Acceptance criteria mapping
```

## Advanced Options

### Include Test Data Files

```
/generate-gherkin 12345 --with-test-data
```

Creates:
- `test-data/orders.json` - Sample test data
- `test-data/users.json` - Test users
- `fixtures/` - Database fixtures

### Generate Complete Test Suite

```
/generate-gherkin 12345 --full-suite
```

Creates:
- Feature files
- Step definitions
- Page objects
- Test configuration
- README with run instructions

### Custom Tags

```
/generate-gherkin 12345 Add tags: @p1 @mobile @api-integration
```

## Integration with CI/CD

Generated features work with:

**Cucumber:**
```bash
npm run test:cucumber
# or
cucumber-js features/
```

**SpecFlow:**
```bash
dotnet test --filter "Category=OrderManagement"
```

**Behave:**
```bash
behave features/ --tags=@smoke
behave features/ --tags=@order-filtering
```

## Quality Checks

Before generating, I verify:
- [ ] Story has clear acceptance criteria
- [ ] ACs are in Given-When-Then format
- [ ] Scenarios are testable
- [ ] Edge cases covered
- [ ] Tags are appropriate
- [ ] Framework syntax is correct

## Examples

### Example 1: Simple Feature
```
/generate-gherkin 12345
```

Output: Single .feature file with all scenarios

### Example 2: With Automation Code
```
/generate-gherkin 12345 cucumber --with-steps
```

Output:
- `date-filtering.feature`
- `filtering.steps.js`
- `page-objects/OrderHistoryPage.js`

### Example 3: Full Epic
```
/generate-gherkin epic-1234
```

Output: Multiple .feature files for all stories in epic

### Example 4: API Testing
```
/generate-gherkin 12345 Add API test scenarios
```

Output: Gherkin for API-level testing (no UI steps)

## Tips

- **Keep scenarios independent**: Each should run alone
- **Use Background wisely**: Only for truly common setup
- **Data-drive when appropriate**: But don't overuse
- **Readable language**: Business-friendly, not technical
- **Meaningful tags**: Enable selective test execution
- **One behavior per scenario**: Don't test multiple things

## Next Steps After Generation

1. **Review generated .feature files**
2. **Implement step definitions** (if not auto-generated)
3. **Add to version control** (git add features/)
4. **Configure test runner** (cucumber.js, behave.ini, etc.)
5. **Run tests**: `npm test` or `behave`
6. **Integrate with CI/CD**

Generated Gherkin scenarios are production-ready and follow BDD best practices!
