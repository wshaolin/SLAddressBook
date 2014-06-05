//
//  SLDateUtil.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-4.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLDateUtil.h"

@implementation SLDateUtil

+ (NSString *)dateToString:(NSDate *)date{
    if (date == nil) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

+ (NSString *)dateTimeToString:(NSDate *)dateTime{
    if (dateTime == nil) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:dateTime];
}

@end
