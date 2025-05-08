import express from "express";
const server = express();

const router = express.Router();

router
    .get("/login", (req, res) => {
        res.send("Voce acessou a tela de login, <a href='/login'>Voltar</a>");
    })

server.use(router);
server.listen(3000, (erro) => {
    console.log("Servidor Rodando na porta 3000");
});