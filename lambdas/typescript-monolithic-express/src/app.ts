import express from 'express';
import { routes } from './routes';

const app = express();

app.use(express.json());

app.use('/', routes);

app.use(
    (
        req: express.Request,
        res: express.Response,
        next: express.NextFunction,
    ) => {
        res.status(404).send();
    },
);

app.use(
    (
        err: unknown,
        req: express.Request,
        res: express.Response,
        next: express.NextFunction,
    ) => {
        //@ts-expect-error eeee
        res.status(err?.status || 500).send();
    },
);

export { app };
