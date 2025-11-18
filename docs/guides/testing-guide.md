# Zartis Testing Guide

**Last Updated:** 2025-01-18
**Maintained By:** Zartis QA Team
**Purpose:** Comprehensive testing guidance and examples

---

## Test Structure Examples

### Unit Test Structure

#### JavaScript/TypeScript (Jest/Vitest)
```javascript
describe('Feature: Order Total Calculation', () => {
  describe('calculateOrderTotal()', () => {
    it('should calculate total with tax', () => {
      // Arrange
      const order = {
        items: [{ price: 100, quantity: 2 }],
        taxRate: 0.1
      };

      // Act
      const total = calculateOrderTotal(order);

      // Assert
      expect(total).toBe(220); // 200 + 10% tax
    });

    it('should handle empty orders', () => {
      const emptyOrder = { items: [], taxRate: 0.1 };
      expect(calculateOrderTotal(emptyOrder)).toBe(0);
    });

    it('should handle multiple items', () => {
      const order = {
        items: [
          { price: 50, quantity: 2 },
          { price: 100, quantity: 1 }
        ],
        taxRate: 0.2
      };
      expect(calculateOrderTotal(order)).toBe(240); // (100 + 100) * 1.2
    });

    it('should throw error for negative prices', () => {
      const invalidOrder = {
        items: [{ price: -10, quantity: 1 }],
        taxRate: 0.1
      };
      expect(() => calculateOrderTotal(invalidOrder)).toThrow('Invalid price');
    });
  });
});
```

#### Java (JUnit)
```java
@DisplayName("Order Total Calculation")
class OrderTotalCalculatorTest {

    private OrderTotalCalculator calculator;

    @BeforeEach
    void setUp() {
        calculator = new OrderTotalCalculator();
    }

    @Test
    @DisplayName("Should calculate total with tax")
    void shouldCalculateTotalWithTax() {
        // Arrange
        Order order = new Order();
        order.addItem(new OrderItem(100.0, 2));
        order.setTaxRate(0.1);

        // Act
        double total = calculator.calculateTotal(order);

        // Assert
        assertEquals(220.0, total, 0.01);
    }

    @Test
    @DisplayName("Should handle empty orders")
    void shouldHandleEmptyOrders() {
        Order emptyOrder = new Order();
        emptyOrder.setTaxRate(0.1);

        assertEquals(0.0, calculator.calculateTotal(emptyOrder), 0.01);
    }

    @ParameterizedTest
    @CsvSource({
        "100, 2, 0.1, 220.0",
        "50, 1, 0.2, 60.0",
        "200, 3, 0.15, 690.0"
    })
    @DisplayName("Should calculate various scenarios")
    void shouldCalculateVariousScenarios(
        double price, int quantity, double taxRate, double expected
    ) {
        Order order = new Order();
        order.addItem(new OrderItem(price, quantity));
        order.setTaxRate(taxRate);

        assertEquals(expected, calculator.calculateTotal(order), 0.01);
    }
}
```

#### .NET (xUnit)
```csharp
public class OrderTotalCalculatorTests
{
    [Fact]
    public void ShouldCalculateTotalWithTax()
    {
        // Arrange
        var order = new Order
        {
            Items = new[] { new OrderItem { Price = 100, Quantity = 2 } },
            TaxRate = 0.1m
        };
        var calculator = new OrderTotalCalculator();

        // Act
        var total = calculator.CalculateTotal(order);

        // Assert
        Assert.Equal(220m, total);
    }

    [Fact]
    public void ShouldHandleEmptyOrders()
    {
        var emptyOrder = new Order { Items = Array.Empty<OrderItem>(), TaxRate = 0.1m };
        var calculator = new OrderTotalCalculator();

        Assert.Equal(0m, calculator.CalculateTotal(emptyOrder));
    }

    [Theory]
    [InlineData(100, 2, 0.1, 220)]
    [InlineData(50, 1, 0.2, 60)]
    [InlineData(200, 3, 0.15, 690)]
    public void ShouldCalculateVariousScenarios(
        decimal price, int quantity, decimal taxRate, decimal expected
    )
    {
        var order = new Order
        {
            Items = new[] { new OrderItem { Price = price, Quantity = quantity } },
            TaxRate = taxRate
        };
        var calculator = new OrderTotalCalculator();

        Assert.Equal(expected, calculator.CalculateTotal(order));
    }
}
```

---

## BDD/Gherkin Examples

### Complete Feature File

```gherkin
Feature: Order History Filtering
  As an operations manager
  I want to filter orders by date range
  So that I can quickly find orders from specific time periods

  Background:
    Given I am logged in as an operations manager
    And the system has the following orders:
      | order_id | customer    | date       | total   |
      | 1001     | John Doe    | 2025-01-05 | $150.00 |
      | 1002     | Jane Smith  | 2025-01-10 | $200.00 |
      | 1003     | Bob Johnson | 2025-01-15 | $75.00  |
      | 1004     | Alice Brown | 2025-01-20 | $300.00 |

  Scenario: Filter orders by date range
    When I filter orders from "2025-01-01" to "2025-01-10"
    Then I should see 2 orders
    And the orders should be:
      | order_id | customer   |
      | 1001     | John Doe   |
      | 1002     | Jane Smith |

  Scenario: Filter returns no results
    When I filter orders from "2025-02-01" to "2025-02-28"
    Then I should see 0 orders
    And I should see the message "No orders found for the selected date range"

  Scenario Outline: Filter with various date ranges
    When I filter orders from "<from_date>" to "<to_date>"
    Then I should see <count> orders

    Examples:
      | from_date  | to_date    | count |
      | 2025-01-01 | 2025-01-07 | 1     |
      | 2025-01-01 | 2025-01-15 | 3     |
      | 2025-01-10 | 2025-01-20 | 3     |
      | 2025-01-15 | 2025-01-31 | 2     |

  Scenario: Clear filter shows all orders
    Given I have filtered orders from "2025-01-01" to "2025-01-10"
    When I click "Clear Filter"
    Then I should see 4 orders

  Scenario: Invalid date range
    When I attempt to filter from "2025-01-15" to "2025-01-01"
    Then I should see an error message "End date must be after start date"
    And the filter should not be applied

  Scenario: Filter persists across page refresh
    Given I have filtered orders from "2025-01-01" to "2025-01-10"
    When I refresh the page
    Then the filter should still show "2025-01-01" to "2025-01-10"
    And I should see 2 orders
```

### Step Definitions

#### Cucumber (JavaScript)
```javascript
// features/step-definitions/order-steps.js
const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');

Given('I am logged in as an operations manager', async function() {
  await this.auth.loginAs('operations_manager', 'password');
  expect(await this.auth.isLoggedIn()).to.be.true;
});

Given('the system has the following orders:', async function(dataTable) {
  const orders = dataTable.hashes();
  for (const order of orders) {
    await this.orderApi.createOrder({
      id: order.order_id,
      customer: order.customer,
      date: order.date,
      total: parseFloat(order.total.replace('$', ''))
    });
  }
});

When('I filter orders from {string} to {string}', async function(from, to) {
  await this.orderPage.setDateRange(from, to);
  await this.orderPage.clickApplyFilter();
  await this.orderPage.waitForResults();
});

Then('I should see {int} orders', async function(expectedCount) {
  const actualCount = await this.orderPage.getOrderCount();
  expect(actualCount).to.equal(expectedCount);
});

Then('the orders should be:', async function(dataTable) {
  const expectedOrders = dataTable.hashes();
  const actualOrders = await this.orderPage.getDisplayedOrders();

  expect(actualOrders).to.have.lengthOf(expectedOrders.length);

  for (let i = 0; i < expectedOrders.length; i++) {
    expect(actualOrders[i].order_id).to.equal(expectedOrders[i].order_id);
    expect(actualOrders[i].customer).to.equal(expectedOrders[i].customer);
  }
});
```

#### SpecFlow (.NET)
```csharp
[Binding]
public class OrderSteps
{
    private readonly ScenarioContext _scenarioContext;
    private readonly AuthHelper _auth;
    private readonly OrderPage _orderPage;
    private readonly OrderApi _orderApi;

    public OrderSteps(ScenarioContext scenarioContext)
    {
        _scenarioContext = scenarioContext;
        _auth = new AuthHelper();
        _orderPage = new OrderPage();
        _orderApi = new OrderApi();
    }

    [Given(@"I am logged in as an operations manager")]
    public async Task GivenIAmLoggedInAsOperationsManager()
    {
        await _auth.LoginAs("operations_manager", "password");
        Assert.IsTrue(await _auth.IsLoggedIn());
    }

    [Given(@"the system has the following orders:")]
    public async Task GivenTheSystemHasTheFollowingOrders(Table table)
    {
        foreach (var row in table.Rows)
        {
            await _orderApi.CreateOrder(new Order
            {
                Id = row["order_id"],
                Customer = row["customer"],
                Date = DateTime.Parse(row["date"]),
                Total = decimal.Parse(row["total"].Replace("$", ""))
            });
        }
    }

    [When(@"I filter orders from ""(.*)"" to ""(.*)""")]
    public async Task WhenIFilterOrdersFrom(string fromDate, string toDate)
    {
        await _orderPage.SetDateRange(fromDate, toDate);
        await _orderPage.ClickApplyFilter();
        await _orderPage.WaitForResults();
    }

    [Then(@"I should see (.*) orders")]
    public async Task ThenIShouldSeeOrders(int expectedCount)
    {
        var actualCount = await _orderPage.GetOrderCount();
        Assert.AreEqual(expectedCount, actualCount);
    }

    [Then(@"the orders should be:")]
    public async Task ThenTheOrdersShouldBe(Table table)
    {
        var expectedOrders = table.Rows.Select(r => new
        {
            OrderId = r["order_id"],
            Customer = r["customer"]
        }).ToList();

        var actualOrders = await _orderPage.GetDisplayedOrders();

        Assert.AreEqual(expectedOrders.Count, actualOrders.Count);

        for (int i = 0; i < expectedOrders.Count; i++)
        {
            Assert.AreEqual(expectedOrders[i].OrderId, actualOrders[i].OrderId);
            Assert.AreEqual(expectedOrders[i].Customer, actualOrders[i].Customer);
        }
    }
}
```

---

## Integration Test Examples

### API Testing (Node.js + Supertest)
```javascript
const request = require('supertest');
const app = require('../app');
const db = require('../database');

describe('Orders API', () => {
  beforeEach(async () => {
    await db.clear();
    await db.seed();
  });

  afterEach(async () => {
    await db.clear();
  });

  describe('GET /api/orders', () => {
    it('should return all orders', async () => {
      const response = await request(app)
        .get('/api/orders')
        .set('Authorization', 'Bearer valid-token')
        .expect(200);

      expect(response.body).toHaveLength(5);
      expect(response.body[0]).toHaveProperty('id');
      expect(response.body[0]).toHaveProperty('customer');
    });

    it('should filter by date range', async () => {
      const response = await request(app)
        .get('/api/orders')
        .query({ from: '2025-01-01', to: '2025-01-10' })
        .set('Authorization', 'Bearer valid-token')
        .expect(200);

      expect(response.body).toHaveLength(2);
      response.body.forEach(order => {
        const orderDate = new Date(order.date);
        expect(orderDate >= new Date('2025-01-01')).toBe(true);
        expect(orderDate <= new Date('2025-01-10')).toBe(true);
      });
    });

    it('should return 401 without authentication', async () => {
      await request(app)
        .get('/api/orders')
        .expect(401);
    });
  });

  describe('POST /api/orders', () => {
    it('should create a new order', async () => {
      const newOrder = {
        customer: 'Test Customer',
        items: [{ product_id: 1, quantity: 2 }],
        total: 200
      };

      const response = await request(app)
        .post('/api/orders')
        .set('Authorization', 'Bearer valid-token')
        .send(newOrder)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.customer).toBe('Test Customer');

      // Verify in database
      const dbOrder = await db.orders.findById(response.body.id);
      expect(dbOrder).toBeDefined();
      expect(dbOrder.customer).toBe('Test Customer');
    });

    it('should validate required fields', async () => {
      const invalidOrder = { customer: 'Test Customer' }; // Missing items

      const response = await request(app)
        .post('/api/orders')
        .set('Authorization', 'Bearer valid-token')
        .send(invalidOrder)
        .expect(400);

      expect(response.body).toHaveProperty('error');
      expect(response.body.error).toContain('items');
    });
  });
});
```

---

## E2E Test Examples

### Playwright (TypeScript)
```typescript
import { test, expect } from '@playwright/test';

test.describe('Order History', () => {
  test.beforeEach(async ({ page }) => {
    // Login
    await page.goto('/login');
    await page.fill('[data-testid="email"]', 'ops@example.com');
    await page.fill('[data-testid="password"]', 'password');
    await page.click('[data-testid="login-button"]');

    // Wait for dashboard
    await expect(page).toHaveURL('/dashboard');
  });

  test('should filter orders by date range', async ({ page }) => {
    // Navigate to orders
    await page.click('[data-testid="orders-nav"]');
    await expect(page).toHaveURL('/orders');

    // Open date filter
    await page.click('[data-testid="filter-button"]');

    // Set date range
    await page.fill('[data-testid="date-from"]', '2025-01-01');
    await page.fill('[data-testid="date-to"]', '2025-01-10');
    await page.click('[data-testid="apply-filter"]');

    // Wait for results
    await page.waitForSelector('[data-testid="order-row"]');

    // Verify filtered results
    const orders = await page.locator('[data-testid="order-row"]').count();
    expect(orders).toBe(2);

    // Verify dates are within range
    const dates = await page.locator('[data-testid="order-date"]').allTextContents();
    dates.forEach(dateStr => {
      const date = new Date(dateStr);
      expect(date >= new Date('2025-01-01')).toBeTruthy();
      expect(date <= new Date('2025-01-10')).toBeTruthy();
    });
  });

  test('should clear filter', async ({ page }) => {
    await page.click('[data-testid="orders-nav"]');

    // Apply filter
    await page.click('[data-testid="filter-button"]');
    await page.fill('[data-testid="date-from"]', '2025-01-01');
    await page.fill('[data-testid="date-to"]', '2025-01-10');
    await page.click('[data-testid="apply-filter"]');

    // Verify filtered
    await expect(page.locator('[data-testid="order-row"]')).toHaveCount(2);

    // Clear filter
    await page.click('[data-testid="clear-filter"]');

    // Verify all orders shown
    await expect(page.locator('[data-testid="order-row"]')).toHaveCount(5);
  });

  test('should show error for invalid date range', async ({ page }) => {
    await page.click('[data-testid="orders-nav"]');
    await page.click('[data-testid="filter-button"]');

    // Set invalid range (end before start)
    await page.fill('[data-testid="date-from"]', '2025-01-15');
    await page.fill('[data-testid="date-to"]', '2025-01-01');
    await page.click('[data-testid="apply-filter"]');

    // Verify error message
    await expect(page.locator('[data-testid="error-message"]'))
      .toHaveText('End date must be after start date');

    // Verify filter not applied
    await expect(page.locator('[data-testid="order-row"]')).toHaveCount(5);
  });
});
```

---

## Test Data Management

### Test Factories (JavaScript)
```javascript
// factories/order.factory.js
const { faker } = require('@faker-js/faker');

const orderFactory = (overrides = {}) => ({
  id: faker.string.uuid(),
  customer: faker.person.fullName(),
  email: faker.internet.email(),
  date: faker.date.recent(),
  items: [
    {
      product_id: faker.number.int({ min: 1, max: 100 }),
      product_name: faker.commerce.productName(),
      quantity: faker.number.int({ min: 1, max: 5 }),
      price: parseFloat(faker.commerce.price())
    }
  ],
  total: parseFloat(faker.commerce.price({ min: 100, max: 1000 })),
  status: faker.helpers.arrayElement(['pending', 'completed', 'cancelled']),
  ...overrides
});

const orderListFactory = (count = 5, overrides = {}) => {
  return Array.from({ length: count }, () => orderFactory(overrides));
};

module.exports = { orderFactory, orderListFactory };
```

### Database Seeding
```javascript
// seeds/orders.seed.js
const { orderFactory } = require('../factories/order.factory');

module.exports = {
  async seed(db) {
    // Clear existing data
    await db.orders.deleteMany({});

    // Create test orders
    const orders = [
      orderFactory({ customer: 'John Doe', date: '2025-01-05', total: 150 }),
      orderFactory({ customer: 'Jane Smith', date: '2025-01-10', total: 200 }),
      orderFactory({ customer: 'Bob Johnson', date: '2025-01-15', total: 75 }),
      orderFactory({ customer: 'Alice Brown', date: '2025-01-20', total: 300 })
    ];

    await db.orders.insertMany(orders);
    return orders;
  },

  async clear(db) {
    await db.orders.deleteMany({});
  }
};
```

---

## Performance Testing

### k6 Load Test Example
```javascript
// load-test/orders-api.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate } from 'k6/metrics';

const errorRate = new Rate('errors');

export const options = {
  stages: [
    { duration: '30s', target: 10 },  // Ramp up to 10 users
    { duration: '1m', target: 10 },   // Stay at 10 users
    { duration: '30s', target: 50 },  // Ramp up to 50 users
    { duration: '2m', target: 50 },   // Stay at 50 users
    { duration: '30s', target: 0 },   // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests < 500ms
    errors: ['rate<0.1'],              // Error rate < 10%
  },
};

const BASE_URL = 'https://api.example.com';
const AUTH_TOKEN = 'Bearer test-token';

export default function() {
  // Test: Get all orders
  let response = http.get(`${BASE_URL}/api/orders`, {
    headers: { Authorization: AUTH_TOKEN },
  });

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  }) || errorRate.add(1);

  sleep(1);

  // Test: Filter orders
  response = http.get(
    `${BASE_URL}/api/orders?from=2025-01-01&to=2025-01-31`,
    { headers: { Authorization: AUTH_TOKEN } }
  );

  check(response, {
    'filtered status is 200': (r) => r.status === 200,
    'filtered response time < 500ms': (r) => r.timings.duration < 500,
  }) || errorRate.add(1);

  sleep(1);
}
```

---

## Questions?

For specific testing scenarios, consult the **qa-specialist** agent:
- BDD/Gherkin scenario generation
- Test strategy recommendations
- Coverage analysis
- Quality gate definition

---

**Remember:** Write tests that give confidence, catch regressions, and enable fearless refactoring.
