//
//  SLContactsRelatedName.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-5.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsRelatedName.h"

@implementation SLContactsRelatedName

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"name = \"%@\"]", self.name];
    return [string copy];
}

@end
