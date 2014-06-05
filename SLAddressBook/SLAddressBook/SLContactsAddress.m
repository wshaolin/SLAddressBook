//
//  SLContactsAddress.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLContactsAddress.h"

@implementation SLContactsAddress

- (NSString *)description{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"[type = \"%@\", ", self.type];
    [string appendFormat:@"country = \"%@\", ", self.country];
    [string appendFormat:@"city = \"%@\", ", self.city];
    [string appendFormat:@"state = \"%@\", ", self.state];
    [string appendFormat:@"street = \"%@\", ", self.street];
    [string appendFormat:@"zip = \"%@\", ", self.zip];
    [string appendFormat:@"countryCode = \"%@\"]", self.countryCode];
    return [string copy];
}

- (NSString *)address{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@", self.country];
    [string appendFormat:@"%@", self.city];
    [string appendFormat:@"%@", self.state];
    [string appendFormat:@"%@", self.street];
    return [string copy];
}

- (NSString *)countryCode{
    if(_countryCode == nil){
        return @"cn";
    }
    return _countryCode;
}

@end
