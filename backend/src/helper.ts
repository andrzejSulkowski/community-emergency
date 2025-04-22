import { Code } from "./types.ts";

function generateCode(): Code {
  const uuid = crypto.randomUUID();

  return {
    id: uuid.substring(0, 6).toUpperCase(),
    created_at: new Date(),
    expires_at: new Date(Date.now() + 24 * 3_600_000),
  };
}

export { generateCode };
