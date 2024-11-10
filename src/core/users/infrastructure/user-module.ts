import {Module } from "@nestjs/common";
import { UserController } from "./user-controller";
import { UserRepository } from "./user-repository";
import { UserServices } from "../application/user-services";

@Module({
controllers: [UserController],
providers: [
    UserServices, 
    UserRepository,
],

})
export class UserModule {}