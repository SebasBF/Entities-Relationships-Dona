import { Module } from '@nestjs/common';
import { UserModule } from './core/users/infrastructure/user-module';

@Module({
  imports: [UserModule],
})
export class AppModule {}
