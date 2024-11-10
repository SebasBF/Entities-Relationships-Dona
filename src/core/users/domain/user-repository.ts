import { UserDto } from "../infrastructure/userDTOs";

export interface IUserRepository{
    register(userDto: UserDto): Promise<UserDto>;
    findUserByEmail(email: string): Promise < UserDto | null>;
    findUserByToken(token:string): Promise < UserDto | null>;
    update(id: number, userDto: Partial<UserDto>): Promise <UserDto | null>;
    updatePassword(id:number, newPassword: string): Promise < UserDto | null>;
    forgotPassword(email: string, token: string): Promise <void>;  
}