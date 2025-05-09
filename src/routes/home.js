import { Router } from 'express';
import { homeController } from '../controllers/index.js';

const routerHome = Router();

routerHome
    .get('/home', homeController.homePage);

export { routerHome };