import {UserDto, UpdateUserDto, ResetPasswordDto } from "../infrastructure/userDTOs";
import { Injectable } from "@nestjs/common";
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { UserRepository } from "../infrastructure/user-repository";

@Injectable()
export class UserServices{
    constructor(private userRepository: UserRepository){}
    
    async registerUser(userDto: UserDto): Promise<UserDto> {
        return this.userRepository.register(userDto);
    }

    async loginUser(email: string, password: string): Promise <{token: string}>{
        const user = await this.userRepository.findUserByEmail(email);     

        if(!user){
            throw "Usuario no encontrado"
        } 
        const isPasswordValid = await bcrypt.compare(password, user.password);

        if (!isPasswordValid) {
            throw new Error('Usuario o contraseña no válidos');
        }
        const token = jwt.sign({email}, process.env.TOKEN_SECRET, { expiresIn: '1h' });
        return {token};       
    }

    async updateUser(id: number, updateUserDto: Partial<UpdateUserDto>): Promise < UserDto | null>{
        if(updateUserDto.password){           
            updateUserDto.password = await bcrypt.hash(updateUserDto.password, 10)
        }  

        return this.userRepository.update(id, updateUserDto);
    }
//
    async forgotPassword(email: string, token:string): Promise <void>{  
        if(!token){
            throw "Tóken no válido"
        }           
        return this.userRepository.forgotPassword(email, token);
    }

    async resetPassword(id:number, {token, newPassword, passwordConfirmation}: ResetPasswordDto): Promise < UserDto | null>{
        const user = this.userRepository.findUserByToken(token);
        if(!user) return null; 

        const arePasswordsEqual = await bcrypt.compare(newPassword, passwordConfirmation);

        if(arePasswordsEqual){

            const hashedPassword = await bcrypt.hash(newPassword,10)
            await this.userRepository.updatePassword(id,hashedPassword)

        }else{ throw "Las contraseñas no son iguales, favor revisar"}
                     
    }

    async getUser(token: string): Promise <UserDto | null>{ 
        const { email } = jwt.verify(token,process.env.TOKEN_SECRET) as {email: string}                   
        const user = await this.userRepository.findUserByEmail(email)               
        return user

    }
}