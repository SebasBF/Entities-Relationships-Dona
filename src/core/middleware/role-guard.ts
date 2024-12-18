import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { Roles } from 'src/utility/roles-decorator';

@Injectable()
export class RolesGuard implements CanActivate{
    constructor(private reflector: Reflector){}
    canActivate(
        context: ExecutionContext
    ): boolean | Promise<boolean>| Observable<boolean> {
        const roles = this.reflector.get(Roles, context.getHandler)     
        if(!roles){
            return false;
        }      

        const request = context.switchToHttp().getRequest();
        const user = request.user;

        if (!user || !user.role) {         
            return false;
        }   
        const isValidRole = [1, 2, 3].includes(user.role);      
        return isValidRole;   
    }
}

