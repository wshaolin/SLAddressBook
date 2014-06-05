//
//  SLContacts.h
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLContactsEmail.h"
#import "SLContactsInstantMessage.h"
#import "SLContactsPhone.h"
#import "SLContactsURL.h"
#import "SLContactsDate.h"
#import "SLContactsAddress.h"
#import "SLContactsRelatedName.h"

typedef enum{
    SLContactsKindTypePerson, // 个人
    SLContactsKindTypeOrganization // 机构
}SLContactsKindType;

@interface SLContacts : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *prefix; // 前缀
@property (nonatomic, copy) NSString *suffix; // 后缀
@property (nonatomic, copy) NSString *nickname; // 昵称
@property (nonatomic, copy) NSString *firstNamePhonetic; //firstName的拼音
@property (nonatomic, copy) NSString *lastNamePhonetic; //lastName的拼音
@property (nonatomic, copy) NSString *middleNamePhonetic; //middleName的拼音
@property (nonatomic, copy) NSString *organization; // 公司
@property (nonatomic, copy) NSString *jobTitle; // 工作
@property (nonatomic, copy) NSString *department; // 部门
@property (nonatomic, copy) NSString *note; // 备忘录
@property (nonatomic, assign) SLContactsKindType kind;// 类别

@property (nonatomic, strong) NSDate *birthday; // 生日
@property (nonatomic, strong) NSDate *creationDate; // 添加日期
@property (nonatomic, strong) NSDate *modificationDate; // 最后修改日期

@property (nonatomic, strong) NSArray *emails; // 邮箱SLContactsEmail类型
@property (nonatomic, strong) NSArray *addresses; // 地址SLContactsAddress类型
@property (nonatomic, strong) NSArray *dates; // 日期SLContactsDate类型
@property (nonatomic, strong) NSArray *instantMessages; //即时信息SLContactsInstantMessage类型
@property (nonatomic, strong) NSArray *phones; // 电话SLContactsPhone类型
@property (nonatomic, strong) NSArray *urls; // url SLContactsURL类型
@property (nonatomic, strong) NSArray *relatedNames; // 相关 SLContactsRelatedName类型

@property (nonatomic, strong) UIImage *photo; // 照片

@end
