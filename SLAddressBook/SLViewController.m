//
//  SLViewController.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "SLViewController.h"
#import "SLAddressBook.h"

@interface SLViewController ()

@end

@implementation SLViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    SLAddressBook *addressBook = [SLAddressBook addressBook];
    NSLog(@"%@", [addressBook contactsWithPhone:@"1310"]);
}

@end
