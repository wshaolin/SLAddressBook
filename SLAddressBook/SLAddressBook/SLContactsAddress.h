//
//  SLContactsAddress.h
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLContactsAddress : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *street;

@property (nonatomic, copy) NSString *zip;

@property (nonatomic, copy) NSString *countryCode;

- (NSString *)address;

@end
