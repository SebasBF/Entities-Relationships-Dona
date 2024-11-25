import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { Roles } from 'src/utility/roles-decorator';

@Injectable()
export class RolesGuard implements CanActivate{
    constructor(private reflector: Reflector){}
    canActivate(context: ExecutionContext): boolean {
        const roles = this.reflector.get(Roles, context.getHandler)
        if(!roles){
            return false;
        }
        //const request = context.switchToHttp().getRequest();
        //const user = request.user
       // return matchRoles(roles, user.roles);
    }
}
