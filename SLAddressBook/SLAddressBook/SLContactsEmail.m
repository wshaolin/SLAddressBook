//
//  SLContactsEmail.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsEmail.h"

@implementation SLContactsEmail

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"emailText = \"%@\"]", self.emailText];
    return [string copy];
}

@end
