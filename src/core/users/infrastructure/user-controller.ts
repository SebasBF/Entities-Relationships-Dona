import { Controller,Post,Put,Body,Param } from "@nestjs/common";
import { UserServices } from "src/core/users/application/user-services";
import { UserDto, UpdateUserDto, ForgotPasswordDto, ResetPasswordDto } from "./userDTOs";
import { Roles } from "src/utility/roles-decorator";

@Controller('users')

export class UserController{
    constructor(private readonly userServices: UserServices){}

    @Post('register')
    async register(@Body() userDto: UserDto){     
        return this.userServices.registerUser(userDto);
    }
    
    @Post('login')
    async login(@Body() userDto: Partial<UserDto>){
        
        return this.userServices.loginUser(userDto.email, userDto.password);

    }

    @Put(':id')
    async update(@Param('id') id:number, @Body() updateUserDto: UpdateUserDto){
        return this.userServices.updateUser(id,updateUserDto);
    }

    @Post('forgot-password')
    async forgotPassword(@Body() forgotPasswordDto: ForgotPasswordDto){
        await this.userServices.forgotPassword(forgotPasswordDto.email, forgotPasswordDto.token);
        return {message: 'Solicitud de restablecimiento de contraseña enviada'};
    }

    @Post('reset-password/:id')
    async resetPassword(@Body() resetPasswordDto: ResetPasswordDto, @Param() id){
        const User = await this.userServices.resetPassword(id, resetPasswordDto);
        if(!User){
          return {message: 'Tóken inválido o expirado, favor intentar de nuevo'};
        }
        return {message: 'restablecimiento de contraseña exitoso.'};
    }
}