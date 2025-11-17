---
name: context-aware-coding
description: Automatically fetches current library documentation via context7 before implementing features, ensuring code uses modern patterns and correct APIs. Invoked when implementing code, fixing bugs, or refactoring. Prevents outdated patterns and deprecated API usage.
allowed-tools: Read, Write, Edit, Bash, mcp__context7__*
---

# Context-Aware Coding Skill

Ensures all code uses current library versions and modern patterns by automatically fetching up-to-date documentation.

## When I Activate

I activate automatically when you:
- Start implementing a feature
- Fix a bug involving a library
- Refactor existing code
- Add a new dependency
- Update a library version
- Mention a specific framework or library

## The Problem I Solve

### Without Context-Aware Coding:
```typescript
// Outdated Next.js pattern (Pages Router)
export async function getServerSideProps(context) {
  const data = await fetch('/api/data');
  return { props: { data } };
}
```

### With Context-Aware Coding:
```typescript
// Current Next.js 14 pattern (App Router with Server Actions)
export async function getData() {
  'use server'
  const data = await fetch('/api/data', {
    next: { revalidate: 3600 }
  });
  return data;
}
```

## How I Work

### 1. Detect Required Libraries

I analyze:
- `package.json` / `requirements.txt` / `Gemfile` for versions
- Import statements in existing code
- The feature being implemented
- Related files that will be modified

Example detection:
```json
{
  "dependencies": {
    "react": "^18.2.0",
    "next": "14.0.4",
    "date-fns": "^3.0.0"
  }
}
```

I identify: React 18, Next.js 14, date-fns 3

### 2. Fetch Current Documentation

I use context7 to fetch:
```
context7 fetch:
- React 18 hooks and patterns
- Next.js 14 App Router documentation
- date-fns v3 API reference
```

### 3. Apply Modern Patterns

I ensure code uses:
- Current API methods
- Latest best practices
- Recommended patterns
- Performance optimizations
- Security improvements

### 4. Validate Against Version

I check:
- No deprecated APIs
- No removed features
- No breaking changes from older versions
- Correct import paths
- Proper configuration

## Examples

### React Hooks (Current vs Outdated)

**Outdated (Class Component):**
```typescript
class UserProfile extends React.Component {
  constructor(props) {
    super(props);
    this.state = { user: null, loading: true };
  }

  componentDidMount() {
    fetchUser(this.props.userId)
      .then(user => this.setState({ user, loading: false }));
  }

  render() {
    return <div>{this.state.loading ? 'Loading...' : this.state.user.name}</div>;
  }
}
```

**Current (Hooks):**
```typescript
function UserProfile({ userId }: { userId: string }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUser(userId)
      .then(setUser)
      .finally(() => setLoading(false));
  }, [userId]);

  return <div>{loading ? 'Loading...' : user?.name}</div>;
}
```

### Authentication (Current Patterns)

**Outdated (custom JWT handling):**
```typescript
// Manual JWT handling (error-prone)
function authenticate(credentials) {
  const token = jwt.sign(credentials, SECRET);
  localStorage.setItem('token', token);
  return token;
}
```

**Current (Auth.js v5):**
```typescript
// Modern Auth.js pattern
import { auth, signIn } from '@/auth';

export async function authenticate(credentials: Credentials) {
  return await signIn('credentials', credentials);
}

export async function getSession() {
  return await auth();
}
```

### State Management (Current Patterns)

**Outdated (Redux boilerplate):**
```typescript
// Lots of boilerplate
const INCREMENT = 'INCREMENT';

function incrementAction() {
  return { type: INCREMENT };
}

function counterReducer(state = 0, action) {
  switch (action.type) {
    case INCREMENT:
      return state + 1;
    default:
      return state;
  }
}
```

**Current (Zustand/Jotai):**
```typescript
// Modern, minimal state management
import { create } from 'zustand';

const useCounterStore = create((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 })),
}));
```

## Library-Specific Patterns

### Next.js 14 App Router
```typescript
// ✅ Current: Server Components by default
export default async function Page() {
  const data = await getData(); // Fetches on server
  return <div>{data}</div>;
}

// ✅ Client components explicitly marked
'use client'
export function InteractiveButton() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(c => c + 1)}>{count}</button>;
}

// ✅ Server Actions for mutations
'use server'
export async function updateUser(formData: FormData) {
  const name = formData.get('name');
  await db.users.update({ name });
  revalidatePath('/profile');
}
```

### React Query v5
```typescript
// ✅ Current v5 syntax
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

function UserProfile() {
  const queryClient = useQueryClient();

  const { data, isLoading } = useQuery({
    queryKey: ['user'],
    queryFn: fetchUser,
    staleTime: 5000,
  });

  const mutation = useMutation({
    mutationFn: updateUser,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user'] });
    },
  });

  return <div>{/* UI */}</div>;
}
```

### Date Handling (date-fns v3)
```typescript
// ✅ Current v3 API
import { format, addDays, isAfter } from 'date-fns';

const formatted = format(new Date(), 'yyyy-MM-dd');
const nextWeek = addDays(new Date(), 7);
const isLater = isAfter(nextWeek, new Date());
```

## Framework Detection

I automatically detect frameworks from:
- File extensions (`.tsx` → React, `.vue` → Vue)
- Config files (`next.config.js`, `vite.config.ts`)
- Package.json dependencies
- Directory structure

## Best Practices I Enforce

### TypeScript
- Strict type checking
- No `any` types (use `unknown` or proper types)
- Proper generic constraints
- Type guards for runtime validation

### Error Handling
- Try-catch for async operations
- Graceful degradation
- User-friendly error messages
- Proper error logging

### Performance
- Memoization where appropriate
- Lazy loading
- Code splitting
- Efficient algorithms

### Security
- Input validation
- XSS prevention
- CSRF protection
- SQL injection prevention
- No secrets in code

### Accessibility
- Semantic HTML
- ARIA attributes
- Keyboard navigation
- Screen reader support

## Version-Specific Handling

When I detect version conflicts:
```
⚠️ Warning: Your code uses React 17 patterns but package.json has React 18
Recommendation: Update to React 18 patterns or downgrade library

Would you like me to:
1. Update code to React 18 patterns
2. Show migration guide
3. Continue with React 17 (not recommended)
```

## Integration with context7

I make intelligent requests:
```
// Instead of generic "React docs"
context7 fetch: "React 18.2 useEffect cleanup and dependency array best practices"

// Instead of "Next.js"
context7 fetch: "Next.js 14 App Router data fetching with Server Actions"

// Instead of "date library"
context7 fetch: "date-fns v3 formatting and timezone handling"
```

## Quality Assurance

Before completing implementation, I verify:
- [ ] Using current API versions
- [ ] No deprecated features
- [ ] Following framework best practices
- [ ] Performance patterns applied
- [ ] Security measures in place
- [ ] Accessibility standards met
- [ ] Tests cover new patterns

## Tips for Best Results

Help me by:
- Keeping dependencies updated in package.json
- Mentioning specific version if different from package.json
- Noting if there are legacy patterns to avoid
- Indicating performance requirements
- Specifying security requirements

I ensure your code stays modern, performant, and maintainable by always using the latest library patterns!
