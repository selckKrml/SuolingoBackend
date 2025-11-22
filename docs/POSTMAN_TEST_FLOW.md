# 🔄 Postman Test Flow Diagram

## Test Execution Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    START: Run Collection                        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  🏠 API Info    │
                    │  GET /          │
                    │  ✓ Version 2.0  │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  👥 USERS    │    │  🤖 AVATARS  │    │ 📚 LEARNING  │
│              │    │              │    │    PATHS     │
└──────┬───────┘    └──────┬───────┘    └──────┬───────┘
       │                   │                    │
       │ GET /users        │ GET /avatars       │ GET /learning_paths
       ├─────────────►     ├──────────────►     ├──────────────►
       │ Set userId        │ Set avatarId       │ Set pathId
       │                   │                    │
       │ POST /users       │ POST /avatars      │ POST /learning_paths
       ├─────────────►     ├──────────────►     ├──────────────►
       │ createdUserId     │ createdAvatarId    │ createdPathId
       │                   │                    │
       │ GET /users/:id    │ GET /avatars/:id   │ GET /paths/:id
       ├─────────────►     ├──────────────►     ├──────────────►
       │ Validate data     │ Validate data      │ Validate data
       │                   │                    │
       │ PUT /users/:id    │                    │
       └─────────────►     │                    │
         Update name       │                    │
                           │                    │
        ┌──────────────────┴────────────────────┘
        │
        ▼
┌────────────────────────────────────────┐
│      💬 CONVERSATIONS                  │
│                                        │
│  Uses: avatarId + learningPathId      │
└─────────────────┬──────────────────────┘
                  │
                  │ GET /conversations
                  ├──────────────────────►
                  │ Set conversationId (IMPORTANT!)
                  │ Validate nested: avatar, learning_path, messages
                  │
                  │ POST /conversations
                  ├──────────────────────►
                  │ createdConversationId
                  │
                  │ GET /conversations/:id
                  ├──────────────────────►
                  │ Check full nested data
                  │
                  │ PUT /conversations/:id
                  └──────────────────────►
                    Update title
                  │
                  │
        ┌─────────┴──────────┐
        │                    │
        ▼                    │
┌─────────────────────────┐  │
│   💌 MESSAGES           │  │
│                         │  │
│  CRITICAL: Uses         │  │
│  conversationId from    │  │
│  previous test!         │  │
└──────────┬──────────────┘  │
           │                 │
           │ GET /conversations/:id/messages
           ├──────────────────────────────────►
           │ Set messageId
           │ Validate: content, sender_type, created_at
           │
           │ POST /conversations/:id/messages
           ├──────────────────────────────────►
           │ createdMessageId
           │ Validate: all fields including audio_url
           │
           │ GET /conversations/:id/messages/:id
           ├──────────────────────────────────►
           │ Validate single message
           │
           │ PUT /conversations/:id/messages/:id
           ├──────────────────────────────────►
           │ Update content
           │
           │ DELETE /conversations/:id/messages/:id
           └──────────────────────────────────►
             Message deleted (204)
           │
           │
           ▼
┌─────────────────────────────────────────┐
│         🗑️ CLEANUP PHASE                │
│                                         │
│  Delete test resources in order        │
└──────────────┬──────────────────────────┘
               │
               │ DELETE /conversations/:id
               ├────────────────────────────►
               │ (Also deletes related messages)
               │
               │ DELETE /users/:id
               ├────────────────────────────►
               │
               │ DELETE /avatars/:id
               ├────────────────────────────►
               │
               │ DELETE /learning_paths/:id
               └────────────────────────────►
                         │
                         ▼
               ┌──────────────────┐
               │  ✅ ALL TESTS    │
               │    COMPLETED!    │
               │                  │
               │  24 requests     │
               │  63 tests passed │
               └──────────────────┘
```

## 🔑 Key Points

### Variable Dependencies
```
userId ──────────┐
                 ├──► Used by: Update User, Delete User
createdUserId ───┘

avatarId ────────┐
                 ├──► Used by: Get Avatar, Create Conversation
createdAvatarId ─┤         Delete Avatar
                 └──► 

learningPathId ──┐
                 ├──► Used by: Get Path, Create Conversation
createdPathId ───┘         Delete Path

conversationId ──┐  ⚠️ CRITICAL!
                 ├──► Used by: ALL Message endpoints
createdConvId ───┤         Update Conversation
                 └──► Delete Conversation

messageId ───────┐
                 ├──► Used by: Get Message, Update Message
createdMessageId─┘         Delete Message
```

### Test Flow Rules

1. **Sequential Execution Required** ✅
   - Each test depends on previous tests setting variables
   - Cannot run tests in parallel
   - Must use Collection Runner or manual order

2. **Resource Creation Order** 🔨
   ```
   Users → Avatars → Learning Paths → Conversations → Messages
   ```

3. **Resource Deletion Order** 🗑️
   ```
   Messages → Conversations → Learning Paths → Avatars → Users
   ```

4. **Why This Order Matters** ⚠️
   - Messages need existing Conversation
   - Conversations need existing Avatar + Learning Path
   - DELETE Conversation removes Messages (cascade)
   - DELETE before GET would cause 404 errors

### Data Preservation Strategy

```
Phase 1: SETUP
├─ Use existing seed data (IDs 1-10)
└─ Store IDs in variables

Phase 2: CREATE
├─ Create new test resources
└─ Use different IDs (dynamic)

Phase 3: READ & UPDATE
├─ Test on existing resources
└─ Validate nested relationships

Phase 4: CLEANUP
├─ Only delete newly created resources
└─ Preserve seed data for future runs
```

## 📊 Timing & Performance

```
Typical Execution Timeline:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

0s    API Info                    ▓░░░░░░░░░░░░░░░░░░░░░░░░
0.5s  Users (4 tests)            ░▓▓▓░░░░░░░░░░░░░░░░░░░░░
1.5s  Avatars (3 tests)          ░░░░▓▓░░░░░░░░░░░░░░░░░░░
2.5s  Learning Paths (3)         ░░░░░░▓▓░░░░░░░░░░░░░░░░░
3.5s  Conversations (4)          ░░░░░░░░▓▓▓░░░░░░░░░░░░░░
5s    Messages (5 tests)         ░░░░░░░░░░░▓▓▓▓░░░░░░░░░░
7s    Cleanup (4 tests)          ░░░░░░░░░░░░░░░▓▓░░░░░░░░
9s    COMPLETE ✅                ░░░░░░░░░░░░░░░░░░▓

Total: ~8-10 seconds
```

## 🎯 Success Indicators

### Console Output Pattern
```
Running tests...
📌 Using user ID: 1
✅ Created user ID: 6
📌 Using avatar: Maria Rodriguez (Spanish)
✅ Created avatar ID: 7
📌 Using learning path: Spanish Beginner Course
✅ Created learning path ID: 9
📌 Using conversation: Ordering Food at a Restaurant (ID: 1)
   Avatar: Maria Rodriguez
   Messages: 5
📨 Found 5 messages
📌 First message ID: 1
✅ Created message ID: 40
✅ Message updated successfully
✅ Message deleted successfully
✅ Test conversation deleted
✅ Test user deleted
✅ Test avatar deleted
✅ Test learning path deleted

🎉 ALL TESTS COMPLETED SUCCESSFULLY! 🎉
```

### Test Results Pattern
```
✓ Status code is 200
✓ Response is array
✓ Users have required fields
✓ Status code is 201
✓ User created successfully
✓ Status code is 200
✓ User details returned
... (63 total tests)
```

## 🚨 Common Failure Points

### ❌ Failure: Messages GET 404
```
GET /conversations/1/messages → 404

Cause: Conversation 1 was deleted
Solution: Use postman_collection_v3_fixed.json
         (Messages tests run BEFORE Conversation DELETE)
```

### ❌ Failure: Variable Not Set
```
PUT /users/{{createdUserId}} → Error: createdUserId not set

Cause: POST /users test was skipped or failed
Solution: Run tests sequentially from the start
```

### ❌ Failure: Nested Data Missing
```
Conversation doesn't have 'avatar' property

Cause: Controller not including nested data
Solution: Check conversations_controller.rb includes(:avatar)
```

## 🔍 Debug Tips

1. **Check Variables Tab**
   - Open collection
   - Click "Variables" tab
   - Verify all IDs are set

2. **Use Console Tab**
   - Bottom panel in Postman
   - See detailed logs
   - Track variable changes

3. **Inspect Responses**
   - Click each request
   - Check "Body" tab
   - Verify JSON structure

4. **Test Individually**
   - Run one request at a time
   - Fix issues before proceeding
   - Save working state

---

**Visualization Legend:**
- 🏠 API / System
- 👥 Users
- 🤖 Avatars
- 📚 Learning Resources
- 💬 Conversations
- 💌 Messages
- 🗑️ Cleanup/Deletion
- ✅ Success
- ⚠️ Critical Point
- ▓ Active Processing
- ░ Completed/Idle
