//
//  SLContactsInstantMessage.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsInstantMessage.h"

@implementation SLContactsInstantMessage

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"account = \"%@\"]", self.account];
    return [string copy];
}

@end
