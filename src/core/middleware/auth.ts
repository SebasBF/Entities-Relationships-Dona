import { Injectable, NestMiddleware } from '@nestjs/common';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  use(req: any, res: any, next: () => void) {
    const token = req.headers['authorization']?.split(' ')[1]; // Extrae el token del header

    if (!token) {
      return res.status(401).json({ message: 'Token no proporcionado o no válido' });
    }

    try {
      const decoded = jwt.verify(token, process.env.TOKEN_SECRET); // Verifica el token
      req.user = decoded; // Añade los datos decodificados al objeto request
      next();
    } 
    catch (err) {
      return res.status(401).json({ message: 'Token inválido o expirado' });
    }
  }
}