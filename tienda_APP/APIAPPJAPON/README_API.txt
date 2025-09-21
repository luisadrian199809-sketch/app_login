
APIAPPJAPON - Simple REST endpoints (for testing)

Files:
- config.php      -> DB connection (edit credentials if needed)
- login.php       -> POST JSON {email, password} -> returns {"success":true,"user":{...}}
- categorias.php  -> GET/POST/PUT/DELETE for categories (JSON)
- productos.php   -> GET/POST/PUT/DELETE for products (JSON)
- panel.php       -> Simple web UI for login + add products (admin only)

Notes:
- These endpoints are intentionally simple for local testing.
- Passwords are in plain text in the provided SQL (for convenience). Change for production.
