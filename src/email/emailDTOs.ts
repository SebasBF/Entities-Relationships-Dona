import { IsEmail, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class SendEmailDto{
@IsEmail()
@IsNotEmpty()
to: string;

@IsNotEmpty()
@IsString()
subject: string;

@IsNotEmpty()
@IsString()
body: string;
}