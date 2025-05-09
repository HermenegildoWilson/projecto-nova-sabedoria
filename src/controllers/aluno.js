class alunoController {
    listarAlunos = (req, res) => {
        res.sendFile('D:/Só Book/My World/Developer/Developing/projecto-nova-sabedoria/views/index.html');
    }
}

export default new alunoController();