import { Router } from "https://deno.land/x/oak@v12.6.1/router.ts";
import { GroupManager } from "./services.ts";

const router = new Router();
// In-memory storage (replace with database later)
const groupManager = new GroupManager();

// Create Group
router.post("/api/group", async (ctx) => {
  const body = await ctx.request.body().value;
  const { userId } = body;
  if (!userId) {
    ctx.response.status = 404; //TODO: check right code for user not found
    ctx.response.body = { msg: "userId has not been provided" };
    return;
  }

  const group = groupManager.createGroup(userId);

  ctx.response.body = { group };
  ctx.response.status = 201;
});

// Get Current User Group
router.get("/api/group/:userId", (ctx) => {
  const { userId } = ctx.params;

  if (!userId) {
    ctx.response.status = 404;
    ctx.response.body = { error: "UserId not found" };
    return;
  }

  const group = groupManager.memberToGroup(userId);
  if (!group) {
    ctx.response.status = 404; //TODO: Code for missing value
    ctx.response.body = { error: "Member not found" };
    return;
  }

  const groupData = {
    ...group.data,
    members: Array.from(group.data.members),
  };

  ctx.response.status = 200;
  ctx.response.body = { group: groupData };
});

// Join a group
router.post("/api/group/:code", async (ctx) => {
  const { code } = ctx.params;
  const body = await ctx.request.body().value;
  const { userId } = body;

  if (!userId) {
    ctx.response.status = 404;
    ctx.response.body = { error: "UserId not found" };
    return;
  }

  const group = groupManager.get(code);
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }

  group.join(userId);

  ctx.response.status = 200;
  ctx.response.body = { msg: "success" };
});

// Raise Alarm
router.put("/api/group/alert", async (ctx) => {
  const body = await ctx.request.body().value;
  const { groupId, userId, isAlarm } = body;

  if (!groupId) {
    ctx.response.status = 400;
    ctx.response.body = { error: "GroupId is required" };
    return;
  }

  if (!userId) {
    ctx.response.status = 400;
    ctx.response.body = { error: "UserId is required" };
    return;
  }

  if (typeof isAlarm !== "boolean") {
    ctx.response.status = 400;
    ctx.response.body = { error: "isAlarm must be a boolean" };
    return;
  }

  const group = groupManager.get(groupId);
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }

  const result = group.setAlert(userId, isAlarm);

  if (result?.msg) {
    ctx.response.status = 300;
    ctx.response.body = { msg: result.msg };
  } else {
    ctx.response.status = 200;
    ctx.response.body = {
      success: true,
      group: {
        ...group.data,
        members: Array.from(group.data.members),
      },
    };
  }
});

// Get group members
router.get("/api/groups/:code/members", (ctx) => {
  const { code } = ctx.params;

  if (!code) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Code not found" };
    return;
  }

  const group = groupManager.get(code);
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }

  ctx.response.body = {
    members: group.getMembers(),
  };
  ctx.response.status = 200;
});

export { router };
