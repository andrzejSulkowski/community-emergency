import { Application, Router } from "https://deno.land/x/oak@v12.6.1/mod.ts";
import { v4 } from "https://deno.land/std@0.208.0/uuid/mod.ts";

interface Group {
  id: string;
  code: string;
  members: Map<string, boolean>;
  createdAt: Date;
}

// In-memory storage (replace with database later)
const groups = new Map<string, Group>();

const app = new Application();
const router = new Router();

// Generate a unique code
function generateCode(): string {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  const random = v4.generate().replace(/-/g, '');
  return random.substring(0, 6).toUpperCase();
}

// Create a new group
router.post("/api/groups", async (ctx) => {
  const code = generateCode();
  const group: Group = {
    id: v4.generate(),
    code,
    members: new Map(),
    createdAt: new Date(),
  };
  
  groups.set(code, group);
  
  ctx.response.body = { code };
  ctx.response.status = 201;
});

// Join a group
router.post("/api/groups/:code/join", async (ctx) => {
  const { code } = ctx.params;
  const group = groups.get(code);
  
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }
  
  const memberId = v4.generate();
  group.members.set(memberId, false);
  
  ctx.response.body = { memberId };
  ctx.response.status = 200;
});

// Update member status
router.put("/api/groups/:code/status", async (ctx) => {
  const { code } = ctx.params;
  const group = groups.get(code);
  
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }
  
  const body = await ctx.request.body().value;
  const { isEmergency } = body;
  
  // Update all members' status (in real app, this would be per member)
  for (const [memberId] of group.members) {
    group.members.set(memberId, isEmergency);
  }
  
  ctx.response.status = 200;
});

// Get group members
router.get("/api/groups/:code/members", async (ctx) => {
  const { code } = ctx.params;
  const group = groups.get(code);
  
  if (!group) {
    ctx.response.status = 404;
    ctx.response.body = { error: "Group not found" };
    return;
  }
  
  ctx.response.body = {
    members: Object.fromEntries(group.members)
  };
  ctx.response.status = 200;
});

// Enable CORS
app.use(async (ctx, next) => {
  ctx.response.headers.set("Access-Control-Allow-Origin", "*");
  ctx.response.headers.set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  ctx.response.headers.set("Access-Control-Allow-Headers", "Content-Type");
  await next();
});

app.use(router.routes());
app.use(router.allowedMethods());

console.log("Server running on http://localhost:3000");
await app.listen({ port: 3000 }); 