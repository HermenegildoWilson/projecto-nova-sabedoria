import express from "express";
const server = express();

import { router } from './src/routes/index.js';
router(server);

server.listen(3000, (erro) => {
    console.log("Servidor Rodando na porta 3000");
});