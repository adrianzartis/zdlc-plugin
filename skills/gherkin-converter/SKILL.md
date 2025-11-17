---
name: gherkin-converter
description: Converts user stories and acceptance criteria into proper Gherkin format for BDD test automation with Cucumber, SpecFlow, or Behave. Automatically invoked when user mentions Gherkin, BDD, Cucumber, SpecFlow, Behave, or requests Feature files. Creates properly structured scenarios with Examples tables.
allowed-tools: Read, Write
---

# Gherkin Converter Skill

Transforms user stories with acceptance criteria into properly formatted Gherkin Feature files for Behavior-Driven Development (BDD).

## When I Activate

I activate automatically when you:
- Mention "Gherkin", "BDD", "Cucumber", "SpecFlow", or "Behave"
- Ask to create ".feature files"
- Request "test scenarios in Gherkin format"
- Say "convert acceptance criteria to Gherkin"
- Want to "generate BDD scenarios"

## What I Do

1. **Parse Acceptance Criteria**
   - Read Given-When-Then format ACs
   - Identify test scenarios
   - Extract test data and examples

2. **Generate Gherkin Feature File**
   - Proper Feature structure
   - Background sections for common setup
   - Scenario or Scenario Outline
   - Examples tables for data-driven tests
   - Tags for test organization

3. **Create Test Automation Structure**
   - Organized by feature area
   - Reusable step definitions
   - Data-driven scenarios
   - Clear, readable format

## Gherkin Format Structure

### Complete Feature File

```gherkin
@order-history @filtering
Feature: Date Range Filtering for Order History
  As an operations manager
  I want to filter order history by selecting a date range
  So that I can quickly find orders from specific time periods

  Background:
    Given I am logged in as an operations manager
    And I am on the order history page
    And there are orders from the past 6 months

  @smoke @critical
  Scenario: Successfully filter orders by date range
    When I click the "Filter by Date" button
    Then I see a date range picker with "From" and "To" fields
    When I select date range from "2025-01-01" to "2025-01-31"
    And I click "Apply Filter"
    Then only orders from January 2025 are displayed
    And the order count shows "Showing 45 of 1,234 orders"
    And the URL includes filter parameters "from=2025-01-01&to=2025-01-31"

  @validation @negative
  Scenario: Prevent invalid date range selection
    When I click the "Filter by Date" button
    And I select "To" date as "2025-01-01"
    And I select "From" date as "2025-01-31"
    Then I see error message "End date must be after start date"
    And the "Apply Filter" button is disabled

  @persistence
  Scenario: Filter persists after page refresh
    Given I have applied a date filter from "2025-01-01" to "2025-01-31"
    When I refresh the page
    Then the date filter is still applied
    And only orders from January 2025 are displayed
    And the date picker shows "2025-01-01" to "2025-01-31"

  @data-driven
  Scenario Outline: Filter with various date ranges
    When I apply filter from "<from_date>" to "<to_date>"
    Then I see "<expected_count>" orders
    And the filter range is displayed as "<display_text>"

    Examples:
      | from_date  | to_date    | expected_count | display_text      |
      | 2025-01-01 | 2025-01-07 | 12            | Last 7 days       |
      | 2025-01-01 | 2025-01-31 | 45            | January 2025      |
      | 2024-12-01 | 2025-01-31 | 103           | Last 2 months     |
      | 2024-01-01 | 2024-12-31 | 1089          | Year 2024         |

  @accessibility @wcag
  Scenario: Keyboard navigation for date filter
    When I navigate to the "Filter by Date" button using Tab key
    And I press Enter
    Then the date picker receives focus
    When I navigate the date picker using arrow keys
    And I select dates using Enter key
    Then the filter is applied correctly
```

## Conversion From Acceptance Criteria

### Input: Acceptance Criteria (Given-When-Then)

```markdown
#### AC1: User can select date range
**Given** I am on the order history page
**When** I click the "Filter by Date" button
**Then** I see a date range picker with "From" and "To" fields

#### AC2: Filter applies to order list
**Given** I have selected a date range (Jan 1 - Jan 31)
**When** I click "Apply Filter"
**Then** Only orders within that date range are displayed
**And** The order count updates to show filtered count
```

### Output: Gherkin Scenario

```gherkin
Scenario: User can select and apply date range filter
  Given I am on the order history page
  When I click the "Filter by Date" button
  Then I see a date range picker with "From" and "To" fields
  When I select date range from "2025-01-01" to "2025-01-31"
  And I click "Apply Filter"
  Then only orders within that date range are displayed
  And the order count updates to show filtered count
```

## Advanced Features

### 1. Data-Driven Scenarios with Examples

When I detect multiple similar test cases, I create Scenario Outlines:

```gherkin
Scenario Outline: Filter validation for various inputs
  When I enter "<from_date>" as From date
  And I enter "<to_date>" as To date
  Then the filter validation shows "<result>"
  And the error message is "<message>"

  Examples:
    | from_date  | to_date    | result | message                           |
    | 2025-01-31 | 2025-01-01 | error  | End date must be after start date |
    | 2025-01-01 | 2025-12-31 | valid  |                                   |
    | invalid    | 2025-01-31 | error  | Invalid date format               |
    | 2025-01-01 | invalid    | error  | Invalid date format               |
```

### 2. Background for Common Setup

I extract common preconditions into Background:

```gherkin
Background:
  Given the following users exist:
    | username | role               |
    | sarah    | operations manager |
    | john     | admin              |
  And I am logged in as "sarah"
  And there are 1234 orders in the system
```

### 3. Tags for Organization

I add meaningful tags:

```gherkin
@smoke          # Critical path tests
@regression     # Full regression suite
@integration    # Integration tests
@unit           # Unit-level tests
@slow           # Long-running tests
@wip            # Work in progress
@skip           # Temporarily disabled
@bug-fix        # Bug verification
@p0, @p1, @p2   # Priority levels
```

### 4. Step Reusability

I create reusable step definitions:

```gherkin
# Reusable steps
Given I am on the {page_name} page
When I click the {button_name} button
Then I see the {element_name} element
And the {field_name} field contains {value}
```

## Framework-Specific Output

### For Cucumber (Ruby/Java/JavaScript)

```gherkin
Feature: Order Filtering

  Scenario: Filter by date
    Given I navigate to "/orders"
    When I select daterange "2025-01-01" to "2025-01-31"
    Then I should see 45 orders
```

### For SpecFlow (.NET/C#)

```gherkin
@WebTest
Feature: Order Filtering
  In order to find specific orders
  As an operations manager
  I want to filter by date range

  Scenario: Filter by date range
    Given I have navigated to the order history page
    When I filter by date range "01/01/2025" to "01/31/2025"
    Then the order list should contain 45 items
```

### For Behave (Python)

```gherkin
Feature: Order Filtering

  @selenium @slow
  Scenario: Filter orders by date
    Given the order history page is loaded
    When I apply date filter from "2025-01-01" to "2025-01-31"
    Then exactly 45 orders should be visible
    And the filter status should display "Filtered by: Jan 1-31, 2025"
```

## File Organization

I organize .feature files by:

```
features/
├── order-management/
│   ├── filtering.feature
│   ├── sorting.feature
│   └── export.feature
├── authentication/
│   ├── login.feature
│   ├── sso.feature
│   └── password-reset.feature
└── dashboard/
    ├── analytics.feature
    └── widgets.feature
```

## Best Practices I Follow

### 1. Clear, Readable Scenarios
- One scenario = one behavior
- Descriptive scenario names
- Imperative language (When I click, Then I see)

### 2. Proper Abstraction
- Hide technical details
- Business-readable language
- No UI element IDs or selectors

### 3. Independent Scenarios
- No dependencies between scenarios
- Each scenario can run alone
- Consistent starting state

### 4. Data-Driven When Appropriate
- Use Examples for multiple similar cases
- Don't overuse (readability matters)
- Keep Examples tables manageable

### 5. Meaningful Tags
- Organize by feature area
- Mark test types (@smoke, @regression)
- Enable selective test runs

## Integration with Test Automation

### Step Definitions (Example)

After generating Gherkin, I can suggest step definitions:

**JavaScript (Cucumber.js):**
```javascript
Given('I am on the {string} page', async function(pageName) {
  await this.page.goto(`/${pageName}`);
});

When('I click the {string} button', async function(buttonText) {
  await this.page.click(`button:has-text("${buttonText}")`);
});

Then('I see {int} orders', async function(expectedCount) {
  const count = await this.page.locator('.order-item').count();
  expect(count).toBe(expectedCount);
});
```

**Python (Behave):**
```python
@given('I am on the {page_name} page')
def step_navigate_to_page(context, page_name):
    context.browser.get(f'/{page_name}')

@when('I click the {button_name} button')
def step_click_button(context, button_name):
    context.browser.find_element_by_text(button_name).click()

@then('I see {count:d} orders')
def step_verify_order_count(context, count):
    orders = context.browser.find_elements_by_class('order-item')
    assert len(orders) == count
```

## Quality Validation

Before outputting, I verify:
- [ ] Proper Gherkin syntax
- [ ] All Given-When-Then steps present
- [ ] Tags are meaningful
- [ ] Scenarios are independent
- [ ] Data tables are well-formed
- [ ] Business-readable language
- [ ] No technical implementation details

## Output Formats

I can generate:
1. **Single .feature file** - One feature
2. **Multiple .feature files** - Full feature suite
3. **Feature file + step definitions** - Ready for automation
4. **Feature file + test data** - With example data files

## Tips for Best Results

Give me:
- Clear acceptance criteria in Given-When-Then format
- Story context (user persona, goal)
- Test data examples
- Edge cases and error scenarios
- Any framework preferences (Cucumber, SpecFlow, Behave)

I'll generate production-ready Gherkin scenarios optimized for your BDD framework!
