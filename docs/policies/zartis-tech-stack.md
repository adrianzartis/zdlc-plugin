# Zartis Technology Stack Guidelines

**Last Updated:** 2025-01-18
**Maintained By:** Zartis Architecture Team
**Purpose:** Guide technology decisions for client and internal projects

---

## Core Philosophy

1. **Customer preference FIRST** - Adapt to client's existing stack
2. **Battle-tested over bleeding-edge** - Prefer proven technologies
3. **Community and talent** - Choose tech with strong communities and available talent
4. **Start simple, scale smart** - Avoid overengineering

---

## Default Technology Stack

*Use these when client has no preference or for internal projects*

### Frontend

#### Frameworks (Choose one)

| Technology | When to Use | Pros | Cons |
|------------|-------------|------|------|
| **React** | Modern SPAs, component-driven UI | Huge ecosystem, flexibility, talent pool | More decisions to make |
| **Angular** | Enterprise apps, large teams | Opinionated, TypeScript-first, complete framework | Steeper learning curve |
| Vue.js | Smaller projects, gradual adoption | Easy to learn, lightweight | Smaller ecosystem than React |

**Default:** React or Angular (based on team expertise)

#### Language

- **TypeScript** (strongly preferred over JavaScript)
  - Type safety reduces bugs
  - Better IDE support
  - Easier to maintain at scale

#### UI Libraries

| Library | Use Case |
|---------|----------|
| **Material-UI (MUI)** | React projects needing Material Design |
| **Ant Design** | Enterprise React applications |
| **Angular Material** | Angular projects |
| **Tailwind CSS** | Utility-first, custom designs |

**Default:** Match client's design system or use Material-UI/Ant Design

#### State Management

| Tool | When to Use |
|------|-------------|
| **React Context + Hooks** | Simple state, small apps |
| **Redux Toolkit** | Complex state, large apps |
| **Zustand** | Lightweight alternative to Redux |
| **NgRx** | Angular apps with complex state |

**Default:** Start with Context/Hooks, add Redux if complexity warrants

---

### Backend

#### Frameworks (Choose based on project)

| Technology | When to Use | Pros | Cons |
|------------|-------------|------|------|
| **Node.js + Express** | APIs, microservices, real-time | JavaScript full-stack, fast development | Single-threaded, CPU-intensive tasks |
| **Node.js + NestJS** | Enterprise Node apps, TypeScript | Structured, Angular-like, TypeScript-first | More boilerplate |
| **Java + Spring Boot** | Enterprise, high-performance, existing Java teams | Robust, mature, strong typing | Verbose, slower startup |
| **.NET Core / .NET 6+** | Microsoft shops, Windows environments | Excellent tooling, performance, Azure integration | Windows-centric (though cross-platform now) |
| **Python (FastAPI/Django)** | Data pipelines, ML integration, APIs | Quick development, ML libraries | Slower than compiled languages |

**Default:**
- **Node.js (Express or NestJS)** for new projects
- **Java Spring Boot** for enterprise/financial clients
- **.NET** for Microsoft-centric clients
- **Python** for data-heavy projects only

#### API Style

| Style | When to Use |
|-------|-------------|
| **REST** | Standard CRUD, public APIs, simple clients |
| **GraphQL** | Complex data fetching, mobile apps (if team has expertise) |
| **gRPC** | Internal microservice communication, high performance |

**Default:** REST (unless client specifically needs GraphQL)

---

### Database

#### Primary Database

| Database | When to Use | Pros | Cons |
|----------|-------------|------|------|
| **PostgreSQL** | Default choice, relational data | ACID, reliable, feature-rich, JSON support | None significant |
| **MySQL** | Client preference, existing MySQL infrastructure | Widely used, simple | Less features than Postgres |
| **MongoDB** | Document-heavy use cases, schema-less needs | Flexible schema, horizontal scaling | No ACID (traditionally), eventual consistency risks |
| **SQL Server** | Microsoft shops, .NET projects | Excellent tooling, Azure integration | Cost (licensing) |

**Default:** **PostgreSQL** (unless client has specific preference)

**When to use NoSQL:**
- Document-heavy data (user profiles, CMS content)
- Extreme horizontal scaling requirements
- Genuinely schema-less data
- **NOT** because "it's easier" or "no migrations"

#### Caching

| Technology | When to Use |
|------------|-------------|
| **Redis** | Session storage, caching, pub/sub, rate limiting |
| **In-Memory (Node/Java)** | Simple caching, single-instance apps |
| **CDN (CloudFlare/Azure CDN)** | Static assets, global distribution |

**Default:** Add Redis when performance measurements show need

#### Message Queue / Event Streaming

| Technology | When to Use |
|------------|-------------|
| **Azure Service Bus** | Azure projects, enterprise messaging |
| **RabbitMQ** | General-purpose messaging, AWS/self-hosted |
| **Apache Kafka** | High-throughput event streaming, event sourcing |
| **AWS SQS** | AWS projects, simple queuing |

**Default:** Cloud-native option (Azure Service Bus on Azure, SQS on AWS)
**When to use Kafka:** Only for high-throughput streaming (>10k messages/sec)

---

### Cloud Infrastructure

#### Cloud Provider

| Provider | When to Use |
|----------|-------------|
| **Azure** | Zartis internal projects, Microsoft-centric clients, .NET apps |
| **AWS** | Client preference, most enterprise clients |
| **GCP** | Client preference, data/ML-heavy projects |

**Default:**
- **Azure** for Zartis internal projects
- **Client's cloud** for client projects

#### Container Orchestration

| Technology | When to Use |
|------------|-------------|
| **Docker** | All projects (containerization baseline) |
| **Azure Container Apps** | Azure, simple container hosting |
| **AWS ECS/Fargate** | AWS, simple container hosting |
| **Kubernetes** | Large-scale, multi-service deployments, experienced teams |

**Default:** Container Apps / ECS for simple deployments
**Kubernetes:** Only if team > 10 people AND multiple services AND DevOps expertise

#### Infrastructure as Code

| Tool | When to Use |
|------|-------------|
| **Terraform** | Multi-cloud, complex infrastructure |
| **ARM Templates** | Azure-only projects |
| **CloudFormation** | AWS-only projects |

**Default:** Terraform (cloud-agnostic, widely used)

---

### Observability & Monitoring

#### Monitoring & Logging

| Tool | When to Use |
|------|-------------|
| **Azure Application Insights** | Azure projects |
| **AWS CloudWatch** | AWS projects |
| **Datadog** | Multi-cloud, advanced monitoring |
| **Grafana + Prometheus** | Self-hosted, Kubernetes environments |

**Default:** Cloud-native option (Application Insights on Azure, CloudWatch on AWS)

#### Error Tracking

| Tool | When to Use |
|------|-------------|
| **Sentry** | Application error tracking |
| **Application Insights** | Azure projects (built-in) |
| **Rollbar** | Alternative to Sentry |

**Default:** Sentry or cloud-native option

---

### Testing

#### Unit Testing

| Tool | When to Use |
|------|-------------|
| **Jest** | JavaScript/TypeScript projects |
| **Vitest** | Modern Vite-based projects (faster than Jest) |
| **JUnit** | Java projects |
| **xUnit / NUnit** | .NET projects |
| **Pytest** | Python projects |

**Default:** Match language ecosystem (Jest for Node, JUnit for Java, etc.)

#### End-to-End Testing

| Tool | When to Use |
|------|-------------|
| **Playwright** | Modern choice, cross-browser, fast |
| **Cypress** | Popular, good DX, visual testing |
| **Selenium** | Legacy choice, broad browser support |

**Default:** **Playwright** (modern, fast, better architecture than Cypress)

#### API Testing

| Tool | When to Use |
|------|-------------|
| **Supertest** | Node.js API testing |
| **RestAssured** | Java API testing |
| **Postman / Newman** | Manual + automated API tests |

---

### CI/CD

#### Pipeline

| Tool | When to Use |
|------|-------------|
| **Azure Pipelines** | Azure DevOps projects |
| **GitHub Actions** | GitHub repositories |
| **GitLab CI** | GitLab repositories |
| **Jenkins** | Legacy, on-premises |

**Default:** **Azure Pipelines** (for ADO) or **GitHub Actions** (for GitHub repos)

---

## Anti-Patterns to Avoid

### ❌ Don't Use These (Without Strong Justification)

1. **Microservices for small teams** (< 5 developers)
   - **Why:** Operational complexity, debugging difficulty, distributed system challenges
   - **Instead:** Modular monolith

2. **GraphQL for simple CRUD** (unless team has expertise)
   - **Why:** Complexity, caching challenges, query optimization needed
   - **Instead:** REST API

3. **NoSQL "because no migrations"**
   - **Why:** Schema still needed, just not enforced; leads to data inconsistency
   - **Instead:** PostgreSQL with proper migrations

4. **Kubernetes for single service** (< 3 services)
   - **Why:** Massive operational overhead for little benefit
   - **Instead:** Container Apps, ECS, or simple VMs

5. **Serverless for everything**
   - **Why:** Cold starts, vendor lock-in, debugging challenges
   - **Instead:** Containers for stateful/long-running; serverless for event-driven

6. **Bleeding-edge tech in production** (just released, < 6 months old)
   - **Why:** Bugs, breaking changes, lack of community support
   - **Instead:** Wait for v1.0 and 6-12 months of community validation

7. **Custom framework/library** (NIH syndrome)
   - **Why:** Maintenance burden, hiring challenges, no community
   - **Instead:** Contribute to existing open-source

8. **MongoDB for relational data** (users, orders, transactions)
   - **Why:** No ACID, no joins, eventual consistency risks
   - **Instead:** PostgreSQL

---

## Decision Framework

### When Evaluating New Technology

Ask these questions:

1. **Maturity:** Is it v1.0+? At least 6 months in production?
2. **Community:** Active GitHub, Stack Overflow answers, recent commits?
3. **Talent:** Can we hire developers who know this?
4. **Maintenance:** Is it actively maintained? Funding/corporate backing?
5. **Alternatives:** What do competitors use? Industry standard?
6. **Lock-in:** Can we migrate away if needed?
7. **Cost:** Total cost of ownership (licenses, infrastructure, training)?

**If 4+ answers are "no" → Choose something else**

### Quick Decision Tree

```
Is this a client project?
├─ YES → Use client's existing stack (unless they ask for recommendation)
└─ NO → Zartis internal

Does team have expertise in Technology X?
├─ YES → Consider using Technology X
└─ NO → Use Zartis default stack

Is this technology proven (v1.0+, 6+ months)?
├─ YES → Check community support
└─ NO → Choose mature alternative

Is there a strong community?
├─ YES → Check if we can hire for it
└─ NO → High risk, choose alternative

Can we easily hire developers?
├─ YES → Acceptable choice
└─ NO → Reconsider unless unique value
```

---

## Client-Specific Adaptations

### Financial Services Clients
- Prefer Java + Spring Boot (mature, proven)
- PostgreSQL or SQL Server
- Strong focus on ACID compliance, audit logs
- Azure or AWS (rarely GCP)

### Startups / Scale-ups
- Node.js + React (fast development)
- PostgreSQL
- Cloud-native (Container Apps, Vercel, etc.)
- Focus on speed to market

### Enterprise Clients
- .NET or Java (based on existing stack)
- Azure (often already committed)
- Strong governance, compliance requirements
- Prefer proven over cutting-edge

### E-commerce Clients
- Node.js or .NET (performance-critical)
- PostgreSQL + Redis (caching critical)
- CDN (CloudFlare, Azure CDN)
- Microservices IF scale justifies (100k+ orders/day)

---

## Technology Radar

### Adopt (Use these confidently)
- React, Angular
- Node.js, .NET Core, Spring Boot
- PostgreSQL
- TypeScript
- Docker
- Azure, AWS
- Playwright

### Trial (Try on non-critical projects)
- Svelte, SvelteKit
- Bun (Node alternative)
- Turso (Edge SQL)
- Astro (static sites)

### Assess (Watch but don't use yet)
- Deno 2.0
- HTMX
- Temporal (workflow engine)

### Hold (Avoid for now)
- AngularJS (legacy)
- MongoDB for transactional data
- Serverless-only architecture
- Microservices for small teams
- Kubernetes for simple apps

---

## Questions?

**Technology decision assistance:** Use `/system-architect` command
**License compliance:** Use `/check-license` command
**Architecture review:** Consult `system-architect` agent

---

**Remember:** Good technology choices balance innovation with pragmatism. When in doubt, choose boring technology.
