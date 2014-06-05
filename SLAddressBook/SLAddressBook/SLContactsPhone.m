//
//  SLContactsPhone.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsPhone.h"

@implementation SLContactsPhone

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"phone = \"%@\"]", self.phone];
    return [string copy];
}

@end
