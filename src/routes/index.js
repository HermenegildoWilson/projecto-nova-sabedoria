import { routerHome } from './home.js';
import { routerAluno } from './aluno.js';


export function router(server) {
    server.use(routerHome);
    server.use(routerAluno);
}