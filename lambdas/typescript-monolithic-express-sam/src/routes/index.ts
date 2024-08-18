import { Request, Response, Router } from 'express';

const greeter = Router();

greeter.get('/', async (req: Request, res: Response) => {
    const name = req.query['name'];

    if (name) res.status(200).send(`Hello ${name}`);
    else res.status(200).send('Hello World');
});

const v1 = Router();

v1.use('/greeter', greeter);

const routes = Router();

routes.use('/v1', v1);

export { routes };
