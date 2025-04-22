import { delay } from "https://deno.land/std@0.224.0/async/delay.ts";


const BASE = "http://localhost:3000"
const BASE_API = `${BASE}/api`

Deno.test("Full API flow: create group → join → alert", async () => {
  // Step 1: Start the API server
  // 
  /*
  const server = new Deno.Command("deno", {
    args: ["run", "-A", "main.ts"],
    stdout: "piped",
    stderr: "piped",
  }).spawn();
  */

  // Step 2: Give the server time to start
  await delay(500); // wait 500ms for server to boot

  // Step 3: Create a fake user and group
  const adminId = "test-admin-user-id";

  // Create group
  const resGroup = await fetch(`${BASE_API}/group`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ userId: adminId }),
  });
  const groupData = await resGroup.json();
  const code = groupData.group.code;

  if (!resGroup.ok || !code) {
    throw new Error("Failed to create group");
  }

  const userId = "test-user-id";

  // Join group
  const resJoin = await fetch(`${BASE_API}/groups/${code}/join`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ userId }),
  });

  if (!resJoin.ok) {
    throw new Error("Failed to join group");
  }

  // Trigger alert
  const resAlert = await fetch(`${BASE_API}/groups/alert`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ code, userId, isEmergency: true }),
  });

  if (!resAlert.ok) {
    throw new Error("Failed to trigger alert");
  }

  // Step 4: Shut down the server
  //server.kill("SIGTERM");
});
