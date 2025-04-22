import { Application } from "https://deno.land/x/oak@v12.6.1/mod.ts";
import { router } from "./router.ts";

const app = new Application();

// Enable CORS
app.use(async (ctx, next) => {
  ctx.response.headers.set("Access-Control-Allow-Origin", "*");
  ctx.response.headers.set(
    "Access-Control-Allow-Methods",
    "GET, POST, PUT, DELETE",
  );
  ctx.response.headers.set("Access-Control-Allow-Headers", "Content-Type");
  await next();
});

app.use(router.routes());
app.use(router.allowedMethods());

console.log("Server running on http://localhost:3000");
await app.listen({ port: 3000 });
