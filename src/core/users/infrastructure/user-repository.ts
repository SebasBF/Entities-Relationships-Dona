import { PrismaClient } from "@prisma/client";
import { IUserRepository } from "../domain/user-repository";
import { User, Token } from "../domain/user-entity";
import jwt from 'jsonwebtoken';
import { Injectable } from "@nestjs/common";
import * as bcrypt from 'bcrypt';
import { UserDto } from "./userDTOs";

const prisma = new PrismaClient()

@Injectable()
export class UserRepository implements IUserRepository{
    async register(userDto: UserDto): Promise<UserDto> {
        
        const hashedPassword = await bcrypt.hash(userDto.password, 10);

        return prisma.user.create({
            data: {
                email: userDto.email,
                password: hashedPassword,
                roleId: 2,
            } 
        });
    }

    async findUserByEmail(email: string): Promise <UserDto | null> {

        const user = await prisma.user.findUnique({
            where: {email}
        })
        
       return user           
    }

    async findUserByToken(token:string): Promise <UserDto | null>{
        const user = await prisma.user.findFirst({
             where: {
                  recoveryToken: token,              
                },
        });
        return user;
    }
    
    async update(id: number, userDto: Partial<UserDto>): Promise<UserDto | null> {

        return prisma.user.update({
            where: { id },
            data: userDto,
      });              
    }

    async updatePassword(id: number, newPassword: string): Promise<UserDto | null> {
        return prisma.user.update({
            where: { id },
            data: {
                password: newPassword,                
            }
        });
    }
    //
    async forgotPassword(email: string, token: string): Promise<void> {
        
        await prisma.user.update({
            where: { email },
            data: {
                recoveryToken: token,             
            },
        });
    } 
    
}