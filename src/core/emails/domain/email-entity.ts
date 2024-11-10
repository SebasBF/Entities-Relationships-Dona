import { SendEmailDto } from "src/email/emailDTOs"

export class email{
    constructor(
        public readonly to: string,
        public readonly subject: string,
        public readonly body: string
      ) {}
}

export interface IemailService{
    sendEmail(sendEmailDto: SendEmailDto): Promise<void>
}