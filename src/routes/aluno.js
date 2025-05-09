import { Router } from 'express';
import { alunoController } from '../controllers/index.js';

const routerAluno = Router();

routerAluno
    .get('/alunos', alunoController.listarAlunos)

export { routerAluno };