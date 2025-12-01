const { Pool } = require("pg");
const pool = new Pool({
    user: "miusuario",
    host: "localhost",
    database: "mibasedatos",
    password: "mipassword",
    port: 5432,
});

module.exports = pool;