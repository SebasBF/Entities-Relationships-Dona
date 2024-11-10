

export class Institution {
    id: number; 
    name: string;  
    address: string; 
    coordinate: {lat: number; lng: number;}; 
    phone: number; 
    email: string;  
    activeHours: string;  
    bloodStorage: number; 
    }
    
    export class Person {
    id: number;
    typeIdentification: string; 
    identification: string; 
    role: string; 
    name: string;  
    lastName: string; 
    dateOfBirth: Date;  
    gender: string; 
    phoneNumber: string; 
    email: string; 
    address: string;  
    coordinate: {lat: number; lng: number;};  
    bloodType: string; 
    }
    
    // informacion del donante 
    export class DonorInfo {
    id: number; 
    personId: number; 
    lastDonation: Date;  
    hasTattoo: boolean;  
    recentIllness: boolean; 
    travelHistory: boolean;  
    medication: boolean;  
    surgery: boolean;  
    pregnancy?: boolean;
    weight: {value: number; unit: 'kg' | 'lbs'};
    height: {value: number; unit: 'cm' | 'ft'};
    }
    
    export class User {
    email: string;     
    password: string;  
    }
      
    
    export class Status {
        id: number;
        status: string;  
    }
    
    export class Role {
    id: number;
    roleName: string;
    description: string;
    }
    
    export class BloodRequest {
    id: number;
    personId: number; 
    centerDonationId: number; 
    identification: string; 
    role: string; 
    name: string;
    lastName: string;
    dateOfBirth: Date; 
    gender: string; 
    bloodType:string; 
    phoneNumber: string;
    amountNeeded: number; 
    address: string; 
    coordinate: {lat: number; lng: number;} ;
    email: string;
    issueDate: Date;
    urgencyId: number; 
    }
    
    export class Donation {
    id: number;
    donorId: number;
    amountDonated: number;
    centerDonationId: number; 
    statusDonation: string;
    request: string;
    dateOfDonation: Date;
    }
    
    export class Chat{
    Id: number;
    personId: number; 
    issueDate: Date;
    }
    
    export class ChatMessages{
    Id: number;
    chatId: number;
    personId: number; 
    chatContent: string;
    dateOfCreation: Date; 
    }
    
    export class Urgency {
    Id: number;
    Priority: string;
    }


