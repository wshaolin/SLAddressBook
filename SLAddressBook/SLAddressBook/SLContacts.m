//
//  SLContacts.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContacts.h"
#import "SLDateUtil.h"

@implementation SLContacts

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"SLContacts = [\nfirstName = \"%@\", ", self.firstName];
    [string appendFormat:@"\nlastName = \"%@\", ", self.lastName];
    [string appendFormat:@"\nmiddleName = \"%@\", ", self.middleName];
    [string appendFormat:@"\nprefix = \"%@\", ", self.prefix];
    [string appendFormat:@"\nsuffix = \"%@\", ", self.suffix];
    [string appendFormat:@"\nnickname = \"%@\", ", self.nickname];
    [string appendFormat:@"\nfirstNamePhonetic = \"%@\", ", self.firstNamePhonetic];
    [string appendFormat:@"\nlastNamePhonetic = \"%@\", ", self.lastNamePhonetic];
    [string appendFormat:@"\nmiddleNamePhonetic = \"%@\", ", self.middleNamePhonetic];
    [string appendFormat:@"\norganization = \"%@\", ", self.organization];
    [string appendFormat:@"\njobTitle = \"%@\", ", self.jobTitle];
    [string appendFormat:@"\ndepartment = \"%@\", ", self.department];
    [string appendFormat:@"\nkind = \"%d\", ", self.kind];
    [string appendFormat:@"\nnote = \"%@\", ", self.note];
    [string appendFormat:@"\nbirthday = \"%@\", ", [SLDateUtil dateToString:self.birthday]];
    [string appendFormat:@"\ncreationDate = \"%@\", ", [SLDateUtil dateTimeToString:self.creationDate]];
    [string appendFormat:@"\nmodificationDate = \"%@\", ", [SLDateUtil dateTimeToString:self.modificationDate]];
    [string appendFormat:@"\nemails = \"%@\", ", [self emailsToString]];
    [string appendFormat:@"\naddresses = \"%@\", ", [self addressesToString]];
    [string appendFormat:@"\ndates = \"%@\", ", [self datesToString]];
    [string appendFormat:@"\ninstantMessages = \"%@\", ", [self instantMessagesToString]];
    [string appendFormat:@"\nphones = \"%@\", ", [self phonesToString]];
    [string appendFormat:@"\nurls = \"%@\", ", [self urlsToString]];
    [string appendFormat:@"\nrelatedNames = \"%@\", ", [self relatedNamesToString]];
    [string appendFormat:@"\nphoto = \"%@\"\n]", self.photo];
    return [string copy];
}

- (NSString *)emailsToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.emails.count; i ++){
        SLContactsEmail *email = self.emails[i];
        [string appendFormat:@"\n%@", email];
        if(i != self.emails.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)addressesToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.addresses.count; i ++){
        SLContactsAddress *address = self.addresses[i];
        [string appendFormat:@"\n%@", address];
        if(i != self.addresses.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)datesToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.dates.count; i ++){
        SLContactsDate *date = self.dates[i];
        [string appendFormat:@"\n%@", date];
        if(i != self.dates.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)instantMessagesToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.instantMessages.count; i ++){
        SLContactsInstantMessage *instantMessage = self.instantMessages[i];
        [string appendFormat:@"\n%@", instantMessage];
        if(i != self.instantMessages.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)phonesToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.phones.count; i ++){
        SLContactsPhone *phone = self.phones[i];
        [string appendFormat:@"\n%@", phone];
        if(i != self.phones.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)urlsToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.urls.count; i ++){
        SLContactsURL *url = self.urls[i];
        [string appendFormat:@"\n%@", url];
        if(i != self.urls.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

- (NSString *)relatedNamesToString{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    for(int i = 0; i < self.relatedNames.count; i ++){
        SLContactsRelatedName *relatedName = self.relatedNames[i];
        [string appendFormat:@"\n%@", relatedName];
        if(i != self.relatedNames.count - 1){
            [string appendString:@","];
        }else{
            [string appendString:@"\n"];
        }
    }
    [string appendString:@"}"];
    return [string copy];
}

@end
