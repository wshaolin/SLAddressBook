//
//  SLAddressBook.h
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLContacts.h"
#import "SLConstants.h"

@interface SLAddressBook : NSObject

+ (instancetype)addressBook;

/**
 *  返回所有的联系人，数组中为SLContacts对象
 *
 */
- (NSArray *)allContacts;

/**
 *  根据联系人名称查找联系人
 *
 *  @param name 联系人名称
 *
 *  @return 返回符合条件的联系人数据，数据中为SLContacts对象
 */
- (NSArray *)contactsWithName:(NSString *)name;

/**
 *  根据联系人电话查找联系人
 *
 *  @param name 联系人电话
 *
 *  @return 返回符合条件的联系人数据，数据中为SLContacts对象
 */
- (NSArray *)contactsWithPhone:(NSString *)phone;

/**
 *  向通讯录中添加一个联系人
 *
 *  @param contacts 联系人
 */
- (void)addContacts:(SLContacts *)contacts;

/**
 *  修改一个已经存在的联系人
 *
 *  @param contacts 联系人
 */
- (void)updateContacts:(SLContacts *)contacts;

/**
 *  删除某个联系人
 *
 *  @param contacts 联系人
 */
- (void)deleteContacts:(SLContacts *)contacts;

@end
