//
//  SLContactsDate.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsDate.h"
#import "SLDateUtil.h"

@implementation SLContactsDate

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"date = \"%@\"]", [SLDateUtil dateToString:self.date]];
    return [string copy];
}

@end
