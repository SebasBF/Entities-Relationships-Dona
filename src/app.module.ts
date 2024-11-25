import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { UserModule } from './core/users/infrastructure/user-module';
import { AuthMiddleware } from './core/middleware/auth';

@Module({
  imports: [UserModule],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware) // Aplica el middleware
      .forRoutes({ path: 'users/forgot-password', method: RequestMethod.POST });     
  }
}
