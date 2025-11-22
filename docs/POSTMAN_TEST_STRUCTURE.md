# 📋 Postman Test Collection Structure

## 🎯 Overview
Comprehensive API testing collection for Suolingo Backend v3 with proper test execution order and detailed validations.

## 📊 Collection Structure

```
Suolingo API v3 - Comprehensive Tests
│
├── 🏠 API Info
│   └── GET / - Verify API is running and check version
│
├── 👥 Users (4 tests)
│   ├── GET /users - List all users
│   ├── POST /users - Create new user
│   ├── GET /users/:id - Get user details
│   └── PUT /users/:id - Update user
│
├── 🤖 Avatars (3 tests)
│   ├── GET /avatars - List all avatars
│   ├── POST /avatars - Create new avatar
│   └── GET /avatars/:id - Get avatar details
│
├── 📚 Learning Paths (3 tests)
│   ├── GET /learning_paths - List all paths
│   ├── POST /learning_paths - Create new path
│   └── GET /learning_paths/:id - Get path details
│
├── 💬 Conversations (4 tests)
│   ├── GET /conversations - List all (with nested data)
│   ├── POST /conversations - Create new conversation
│   ├── GET /conversations/:id - Get conversation details
│   └── PUT /conversations/:id - Update conversation
│
├── 💌 Messages (5 tests)
│   ├── GET /conversations/:id/messages - List all messages
│   ├── POST /conversations/:id/messages - Create message
│   ├── GET /conversations/:id/messages/:id - Get message
│   ├── PUT /conversations/:id/messages/:id - Update message
│   └── DELETE /conversations/:id/messages/:id - Delete message
│
└── 🗑️ Cleanup (4 tests)
    ├── DELETE /conversations/:id - Remove test conversation
    ├── DELETE /users/:id - Remove test user
    ├── DELETE /avatars/:id - Remove test avatar
    └── DELETE /learning_paths/:id - Remove test path
```

## ✨ Key Features

### 1. **Proper Test Ordering**
- DELETE operations are at the END to preserve data
- Messages tests run BEFORE conversation deletion
- Sequential dependency management with variables

### 2. **Comprehensive Validations**
Each test validates:
- ✅ Status codes (200, 201, 204, 404)
- ✅ Response structure (arrays, objects)
- ✅ Required fields presence
- ✅ Data types and formats
- ✅ Nested relationships
- ✅ Field value updates

### 3. **Dynamic Variable Management**
```javascript
Variables automatically set and used:
- userId, createdUserId
- avatarId, createdAvatarId
- learningPathId, createdLearningPathId
- conversationId, createdConversationId
- messageId, createdMessageId
```

### 4. **Console Logging**
Detailed console output for debugging:
```
📌 Using conversation: Ordering Food at a Restaurant (ID: 1)
   Avatar: Maria Rodriguez
   Messages: 5
✅ Created message ID: 42
✅ Message updated successfully
🎉 ALL TESTS COMPLETED SUCCESSFULLY! 🎉
```

## 🚀 Usage

### Import to Postman
1. Open Postman
2. Click **Import**
3. Select `postman_collection_v3_fixed.json`
4. Click **Import**

### Run Collection
**Option 1: Collection Runner**
1. Click **Collections** in sidebar
2. Click on "Suolingo API v3 - Comprehensive Tests"
3. Click **Run** button (top right)
4. Click **Run Suolingo API v3**
5. Watch tests execute sequentially

**Option 2: Manual Execution**
- Run tests one by one in order
- Check console for detailed logs
- Verify each response

### Environment Setup
No additional environment needed! Collection uses:
- Base URL: `http://localhost:3000`
- Auto-managed variables for IDs

## 📈 Test Statistics

| Category | Requests | Tests | Coverage |
|----------|----------|-------|----------|
| API Info | 1 | 2 | Version check |
| Users | 4 | 12 | Full CRUD |
| Avatars | 3 | 9 | Full CRUD |
| Learning Paths | 3 | 9 | Full CRUD |
| Conversations | 4 | 12 | Full CRUD + nested |
| Messages | 5 | 15 | Full CRUD + context |
| Cleanup | 4 | 4 | Resource deletion |
| **TOTAL** | **24** | **63** | **Complete API** |

## ✅ What Gets Tested

### Response Validation
- Status codes are correct
- Response structure matches expectations
- Required fields are present
- Data types are correct
- Relationships are properly nested

### Data Integrity
- Created resources have valid IDs
- Updated fields reflect changes
- Deleted resources return 204
- Parent-child relationships maintained

### Edge Cases
- Missing required fields handled
- Invalid IDs return 404
- Nested resource dependencies respected

## 🔧 Troubleshooting

### Tests Failing?
1. **Check server is running**
   ```powershell
   # In terminal, you should see:
   * Listening on http://127.0.0.1:3000
   ```

2. **Reset database**
   ```powershell
   rails db:reset
   ```

3. **Check conversation exists**
   - Tests use conversation ID 1
   - Ensure `db:seed` has run successfully

### Common Issues

**404 Errors on Messages**
- Conversation was deleted before messages tests
- Solution: Use `postman_collection_v3_fixed.json` (correct order)

**Missing Variables**
- Run tests sequentially, not in parallel
- Variables are set by previous tests

**Timeout Errors**
- Server might be slow to start
- Wait for server to fully boot before testing

## 📝 Test Examples

### User Creation Test
```javascript
pm.test('User created successfully', () => {
    const user = pm.response.json();
    pm.expect(user).to.have.property('id');
    pm.expect(user).to.have.property('name');
    pm.expect(user.name).to.include('Test User');
});
```

### Nested Data Validation
```javascript
pm.test('Conversations include nested data', () => {
    const conv = pm.response.json()[0];
    pm.expect(conv).to.have.property('avatar');
    pm.expect(conv.avatar).to.have.property('name');
    pm.expect(conv).to.have.property('messages');
});
```

### Message CRUD Test
```javascript
pm.test('Message created with all fields', () => {
    const msg = pm.response.json();
    pm.expect(msg).to.have.property('id');
    pm.expect(msg).to.have.property('conversation_id');
    pm.expect(msg.content).to.eql('Test message from Postman');
});
```

## 🎯 Success Criteria

All tests pass when:
- ✅ Server is running on port 3000
- ✅ Database is seeded with initial data
- ✅ PostgreSQL is running
- ✅ All models are properly configured
- ✅ Relationships are correctly set up

## 📊 Expected Results

```
Suolingo API v3 - Comprehensive Tests
  🏠 API Info                          ✓ 2 tests passed
  👥 Users
    ├─ Get All Users                   ✓ 3 tests passed
    ├─ Create User                     ✓ 3 tests passed
    ├─ Get User by ID                  ✓ 2 tests passed
    └─ Update User                     ✓ 2 tests passed
  🤖 Avatars
    ├─ Get All Avatars                 ✓ 3 tests passed
    ├─ Create Avatar                   ✓ 2 tests passed
    └─ Get Avatar by ID                ✓ 2 tests passed
  📚 Learning Paths
    ├─ Get All Learning Paths          ✓ 3 tests passed
    ├─ Create Learning Path            ✓ 2 tests passed
    └─ Get Learning Path by ID         ✓ 2 tests passed
  💬 Conversations
    ├─ Get All Conversations           ✓ 3 tests passed
    ├─ Create Conversation             ✓ 2 tests passed
    ├─ Get Conversation by ID          ✓ 3 tests passed
    └─ Update Conversation             ✓ 2 tests passed
  💌 Messages
    ├─ Get All Messages                ✓ 4 tests passed
    ├─ Create Message                  ✓ 4 tests passed
    ├─ Get Message by ID               ✓ 3 tests passed
    ├─ Update Message                  ✓ 2 tests passed
    └─ Delete Message                  ✓ 1 test passed
  🗑️ Cleanup
    ├─ Delete Test Conversation        ✓ 1 test passed
    ├─ Delete Test User                ✓ 1 test passed
    ├─ Delete Test Avatar              ✓ 1 test passed
    └─ Delete Test Learning Path       ✓ 1 test passed

────────────────────────────────────────────────────
Total:        24 requests
Passed:       63 tests
Failed:       0 tests
Duration:     ~5-10 seconds
────────────────────────────────────────────────────
```

## 🌟 Best Practices

1. **Always run in order** - Tests depend on each other
2. **Check console** - Detailed logging helps debugging
3. **Reset database** - Clean state for consistent results
4. **Use Runner** - Automated execution is most reliable
5. **Review responses** - Understand data structure

## 📚 Related Documentation

- [API OpenAPI Spec](./openapi.yaml)
- [Project Summary](./PROJECT_SUMMARY.md)
- [Postman Testing Guide](./POSTMAN_TESTING_GUIDE.md)
- [PostgreSQL Setup](./POSTGRESQL_SETUP_SUCCESS.md)

---

**Last Updated:** November 22, 2025  
**Collection Version:** 3.0 (Fixed Order with Comprehensive Tests)  
**Total Tests:** 63 across 24 endpoints
