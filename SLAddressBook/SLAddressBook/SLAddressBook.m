//
//  SLAddressBook.m
//  SLAddressBook
//
//  Created by wshaolin on 14-6-3.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "SLAddressBook.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation SLAddressBook

+ (instancetype)addressBook{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if(self){
        [self requestAccessAddressBook];
    }
    return self;
}

/**
 *  请求访问通讯录
 */
- (void)requestAccessAddressBook{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool greanted, CFErrorRef error){
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    CFRelease(addressBook);
}

- (NSArray *)allContacts{
    return [self contactsWithName:nil];
}

- (NSArray *)contactsWithName:(NSString *)name{
    NSMutableArray *allContacts = [NSMutableArray array];
    // 授权成功
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        CFArrayRef peopleArray = NULL;
        if(name.length){
            CFStringRef cfName = (__bridge CFStringRef)(name);
            peopleArray = ABAddressBookCopyPeopleWithName(addressBook, cfName);
        }else{
            peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
        }
        
        if(peopleArray != NULL){
            for(CFIndex index = 0; index < CFArrayGetCount(peopleArray); index ++){
                ABRecordRef record = CFArrayGetValueAtIndex(peopleArray, index);
                if(record != NULL){
                    [allContacts addObject:[self recordToContacts:record]];
                }
            }
        }
        CFRelease(peopleArray);
        CFRelease(addressBook);
    }
    return [allContacts copy];
}

- (SLContacts *)recordToContacts:(ABRecordRef)record{
    SLContacts *contacts = [[SLContacts alloc] init];
    contacts.firstName = (__bridge NSString *)(ABRecordCopyValue(record, kABPersonFirstNameProperty));
    contacts.lastName = (__bridge NSString*)ABRecordCopyValue(record, kABPersonLastNameProperty);
    contacts.middleName = (__bridge NSString*)ABRecordCopyValue(record, kABPersonMiddleNameProperty);
    contacts.prefix = (__bridge NSString*)ABRecordCopyValue(record, kABPersonPrefixProperty);
    contacts.suffix = (__bridge NSString*)ABRecordCopyValue(record, kABPersonSuffixProperty);
    contacts.nickname = (__bridge NSString*)ABRecordCopyValue(record, kABPersonNicknameProperty);
    contacts.firstNamePhonetic = (__bridge NSString*)ABRecordCopyValue(record, kABPersonFirstNamePhoneticProperty);
    contacts.lastNamePhonetic = (__bridge NSString*)ABRecordCopyValue(record, kABPersonLastNamePhoneticProperty);
    contacts.middleNamePhonetic = (__bridge NSString*)ABRecordCopyValue(record, kABPersonMiddleNamePhoneticProperty);
    contacts.organization = (__bridge NSString*)ABRecordCopyValue(record, kABPersonOrganizationProperty);
    contacts.jobTitle = (__bridge NSString*)ABRecordCopyValue(record, kABPersonJobTitleProperty);
    contacts.note = (__bridge NSString*)ABRecordCopyValue(record, kABPersonNoteProperty);
    contacts.department = (__bridge NSString*)ABRecordCopyValue(record, kABPersonDepartmentProperty);
    contacts.birthday = (__bridge NSDate*)ABRecordCopyValue(record, kABPersonBirthdayProperty);
    contacts.creationDate = (__bridge NSDate*)ABRecordCopyValue(record, kABPersonCreationDateProperty);
    contacts.modificationDate = (__bridge NSDate*)ABRecordCopyValue(record, kABPersonModificationDateProperty);
    CFNumberRef kind = ABRecordCopyValue(record, kABPersonKindProperty);
    if(kind == kABPersonKindOrganization){
        contacts.kind = SLContactsKindTypeOrganization;
    }else{
        contacts.kind = SLContactsKindTypePerson;
    }
    CFRelease(kind);
    contacts.emails = [self allContactsEmail:record];
    contacts.addresses = [self allContactsAddress:record];
    contacts.instantMessages = [self allContactsInstantMessage:record];
    contacts.phones = [self allContactsPhone:record];
    contacts.dates = [self allContactsDate:record];
    contacts.urls = [self allContactsURL:record];
    contacts.relatedNames = [self allRelatedName:record];
    
    NSData *imageData = (__bridge NSData*)ABPersonCopyImageData(record);
    if(imageData){
        contacts.photo = [UIImage imageWithData:imageData];
    }
    return contacts;
}

- (NSArray *)allContactsEmail:(ABRecordRef)record{
    NSMutableArray *allEmail = [NSMutableArray array];
    ABMultiValueRef emailMultiValue = ABRecordCopyValue(record, kABPersonEmailProperty);
    if(emailMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(emailMultiValue); index ++){
            SLContactsEmail *email = [[SLContactsEmail alloc] init];
            email.type =  (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emailMultiValue, index)));
            email.emailText = (__bridge NSString *)ABMultiValueCopyValueAtIndex(emailMultiValue, index);
            [allEmail addObject:email];
        }
    }
    CFRelease(emailMultiValue);
    return [allEmail copy];
}

- (NSArray *)allContactsAddress:(ABRecordRef)record{
    NSMutableArray *allAddress = [NSMutableArray array];
    ABMultiValueRef addressMultiValue = ABRecordCopyValue(record, kABPersonAddressProperty);
    if(addressMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(addressMultiValue); index ++){
            SLContactsAddress *address = [[SLContactsAddress alloc] init];
            address.type = (__bridge NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(addressMultiValue, index));
            NSDictionary *addressDictionary = (__bridge NSDictionary *)(ABMultiValueCopyValueAtIndex(addressMultiValue, index));
            address.country = addressDictionary[(__bridge NSString *)kABPersonAddressCountryKey];
            address.city = addressDictionary[(__bridge NSString *)kABPersonAddressCityKey];
            address.state = addressDictionary[(__bridge NSString *)kABPersonAddressStateKey];
            address.street = addressDictionary[(__bridge NSString *)kABPersonAddressStreetKey];
            address.zip = addressDictionary[(__bridge NSString *)kABPersonAddressZIPKey];
            address.countryCode = addressDictionary[(__bridge NSString *)kABPersonAddressCountryCodeKey];
            [allAddress addObject:address];
        }
    }
    CFRelease(addressMultiValue);
    return [allAddress copy];
}

- (NSArray *)allContactsDate:(ABRecordRef)record{
    NSMutableArray *allDate = [NSMutableArray array];
    ABMultiValueRef dateMultiValue = ABRecordCopyValue(record, kABPersonDateProperty);
    if(dateMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(dateMultiValue); index ++){
            SLContactsDate *date = [[SLContactsDate alloc] init];
            date.type = (__bridge NSString *)ABAddressBookCopyLocalizedLabel(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dateMultiValue, index)));
            date.date = (__bridge NSDate *)(ABMultiValueCopyValueAtIndex(dateMultiValue, index));
            [allDate addObject:date];
        }
    }
    CFRelease(dateMultiValue);
    return [allDate copy];
}

- (NSArray *)allContactsInstantMessage:(ABRecordRef)record{
    NSMutableArray *allInstantMessage = [NSMutableArray array];
    ABMultiValueRef instantMessageMultiValue = ABRecordCopyValue(record, kABPersonInstantMessageProperty);
    if(instantMessageMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(instantMessageMultiValue); index ++){
            SLContactsInstantMessage *instantMessage = [[SLContactsInstantMessage alloc] init];
            NSDictionary *instantMessageDictionary = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(instantMessageMultiValue, index);
            instantMessage.account = instantMessageDictionary[(__bridge NSString *)kABPersonInstantMessageUsernameKey];
            instantMessage.type = instantMessageDictionary[(__bridge NSString *)kABPersonInstantMessageServiceKey];
            [allInstantMessage addObject:instantMessage];
        }
    }
    CFRelease(instantMessageMultiValue);
    return [allInstantMessage copy];
}

- (NSArray *)allContactsPhone:(ABRecordRef)record{
    NSMutableArray *allPhone = [NSMutableArray array];
    ABMultiValueRef phoneMultiValue = ABRecordCopyValue(record, kABPersonPhoneProperty);
    if(phoneMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(phoneMultiValue); index ++){
            SLContactsPhone *phone = [[SLContactsPhone alloc] init];
            phone.type = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phoneMultiValue, index)));
            phone.phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneMultiValue, index));
            [allPhone addObject:phone];
        }
    }
    CFRelease(phoneMultiValue);
    return [allPhone copy];
}

- (NSArray *)allContactsURL:(ABRecordRef)record{
    NSMutableArray *allURL = [NSMutableArray array];
    ABMultiValueRef urlMultiValue = ABRecordCopyValue(record, kABPersonURLProperty);
    if(urlMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(urlMultiValue); index ++){
            SLContactsURL *URL = [[SLContactsURL alloc] init];
            URL.type = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(urlMultiValue, index)));
            URL.url = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(urlMultiValue, index));
            [allURL addObject:URL];
        }
    }
    CFRelease(urlMultiValue);
    return [allURL copy];
}

- (NSArray *)allRelatedName:(ABRecordRef)record{
    NSMutableArray *allURL = [NSMutableArray array];
    ABMultiValueRef relatedNameMultiValue = ABRecordCopyValue(record, kABPersonRelatedNamesProperty);
    if(relatedNameMultiValue != NULL){
        for(CFIndex index = 0; index < ABMultiValueGetCount(relatedNameMultiValue); index ++){
            SLContactsRelatedName *relatedName = [[SLContactsRelatedName alloc] init];
            relatedName.type = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(relatedNameMultiValue, index)));
            relatedName.name = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(relatedNameMultiValue, index));
            [allURL addObject:relatedName];
        }
    }
    CFRelease(relatedNameMultiValue);
    return [allURL copy];
}

- (void)addContacts:(SLContacts *)contacts{
    // 授权成功
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABRecordRef record = ABPersonCreate();
        ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)contacts.firstName, NULL);
        ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)contacts.lastName, NULL);
        ABRecordSetValue(record, kABPersonMiddleNameProperty, (__bridge CFStringRef)contacts.middleName, NULL);
        ABRecordSetValue(record, kABPersonPrefixProperty, (__bridge CFStringRef)contacts.prefix, NULL);
        ABRecordSetValue(record, kABPersonSuffixProperty, (__bridge CFStringRef)contacts.suffix, NULL);
        ABRecordSetValue(record, kABPersonNicknameProperty, (__bridge CFStringRef)contacts.nickname, NULL);
        ABRecordSetValue(record, kABPersonFirstNamePhoneticProperty, (__bridge CFStringRef)contacts.firstNamePhonetic, NULL);
        ABRecordSetValue(record, kABPersonLastNamePhoneticProperty, (__bridge CFStringRef)contacts.lastNamePhonetic, NULL);
        ABRecordSetValue(record, kABPersonMiddleNamePhoneticProperty, (__bridge CFStringRef)contacts.middleNamePhonetic, NULL);
        ABRecordSetValue(record, kABPersonOrganizationProperty, (__bridge CFStringRef)contacts.organization, NULL);
        ABRecordSetValue(record, kABPersonJobTitleProperty, (__bridge CFStringRef)contacts.jobTitle, NULL);
        ABRecordSetValue(record, kABPersonDepartmentProperty, (__bridge CFStringRef)contacts.department, NULL);
        ABRecordSetValue(record, kABPersonNoteProperty, (__bridge CFStringRef)contacts.note, NULL);
        if(contacts.kind == SLContactsKindTypeOrganization){
            ABRecordSetValue(record, kABPersonKindProperty, kABPersonKindOrganization, NULL);
        }else{
            ABRecordSetValue(record, kABPersonKindProperty, kABPersonKindPerson, NULL);
        }
        
        ABRecordSetValue(record, kABPersonBirthdayProperty, (__bridge CFDateRef)contacts.birthday, NULL);
        ABRecordSetValue(record, kABPersonCreationDateProperty, (__bridge CFDateRef)contacts.creationDate, NULL);
        ABRecordSetValue(record, kABPersonModificationDateProperty, (__bridge CFDateRef)contacts.modificationDate, NULL);
        
        if(contacts.emails.count){
            ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            for(int i = 0; i < contacts.emails.count; i ++){
                SLContactsEmail *email = contacts.emails[i];
                ABMultiValueAddValueAndLabel(emailMultiValue, (__bridge CFStringRef)email.emailText, (__bridge CFStringRef)email.type, NULL);
            }
            ABRecordSetValue(record, kABPersonEmailProperty, emailMultiValue, NULL);
            CFRelease(emailMultiValue);
        }
        
        if(contacts.addresses.count){
            ABMutableMultiValueRef addressMultiValue = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
            for(int i = 0; i < contacts.addresses.count; i ++){
                SLContactsAddress *address = contacts.addresses[i];
                NSMutableDictionary *addressDictionary = [NSMutableDictionary dictionary];
                addressDictionary[(__bridge NSString *)kABPersonAddressStreetKey] = address.street;
                addressDictionary[(__bridge NSString *)kABPersonAddressCityKey] = address.city;
                addressDictionary[(__bridge NSString *)kABPersonAddressZIPKey] = address.zip;
                addressDictionary[(__bridge NSString *)kABPersonAddressCountryKey] = address.country;
                addressDictionary[(__bridge NSString *)kABPersonAddressStateKey] = address.state;
                addressDictionary[(__bridge NSString *)kABPersonAddressCountryCodeKey] = address.countryCode;
                ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFDictionaryRef)(addressDictionary), (__bridge CFStringRef)address.type, NULL);
            }
            ABRecordSetValue(record, kABPersonAddressProperty, addressMultiValue, NULL);
            CFRelease(addressMultiValue);
        }
        
        if(contacts.dates.count){
            ABMutableMultiValueRef dateMultiValue = ABMultiValueCreateMutable(kABMultiDateTimePropertyType);
            for(int i = 0; i < contacts.dates.count; i ++){
                SLContactsDate *date = contacts.dates[i];
                ABMultiValueAddValueAndLabel(dateMultiValue, (__bridge CFDateRef)date.date, (__bridge CFStringRef)date.type , NULL);
            }
            ABRecordSetValue(record, kABPersonDateProperty, dateMultiValue, NULL);
            CFRelease(dateMultiValue);
        }
        
        if(contacts.instantMessages.count){
            ABMutableMultiValueRef instantMessagesMultiValue = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
            NSMutableDictionary *instantMessagesDictionary = [NSMutableDictionary dictionary];
            for(int i = 0; i < contacts.instantMessages.count; i ++){
                SLContactsInstantMessage *instantMessage = contacts.instantMessages[i];
                instantMessagesDictionary[instantMessage.type] = instantMessage.account;
            }
            ABRecordSetValue(record, kABPersonInstantMessageProperty, instantMessagesMultiValue, NULL);
            CFRelease(instantMessagesMultiValue);
        }
        
        if(contacts.phones.count){
            ABMutableMultiValueRef phonesMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            for(int i = 0; i < contacts.phones.count; i ++){
                SLContactsPhone *phone = contacts.phones[i];
                ABMultiValueAddValueAndLabel(phonesMultiValue, (__bridge CGShadingRef)phone.phone, (__bridge CFStringRef)phone.type, NULL);
            }
            ABRecordSetValue(record, kABPersonPhoneProperty, phonesMultiValue, NULL);
            CFRelease(phonesMultiValue);
        }
        
        if(contacts.urls.count){
            ABMutableMultiValueRef urlsMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            for(int i = 0; i < contacts.urls.count; i ++){
                SLContactsURL *url = contacts.urls[i];
                ABMultiValueAddValueAndLabel(urlsMultiValue, (__bridge CFStringRef)url.url, (__bridge CFStringRef)url.type, NULL);
            }
            ABRecordSetValue(record, kABPersonURLProperty, urlsMultiValue, NULL);
            CFRelease(urlsMultiValue);
        }
        
        if(contacts.relatedNames.count){
            ABMutableMultiValueRef relatedNamesMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            for(int i = 0; i < contacts.relatedNames.count; i ++){
                SLContactsRelatedName *relatedName = contacts.relatedNames[i];
                ABMultiValueAddValueAndLabel(relatedNamesMultiValue, (__bridge CFStringRef)relatedName.name, (__bridge CFStringRef)relatedName.type, NULL);
            }
            ABRecordSetValue(record, kABPersonRelatedNamesProperty, relatedNamesMultiValue, NULL);
            CFRelease(relatedNamesMultiValue);
        }
        
        if(contacts.photo){
            NSData *photoData = UIImageJPEGRepresentation(contacts.photo, 1.0);
            ABPersonSetImageData(record, (__bridge CFDataRef)photoData, NULL);
        }
        
        ABAddressBookAddRecord(addressBook, record, NULL);
        ABAddressBookSave(addressBook, NULL);
        CFRelease(addressBook);
    }
}

- (void)updateContacts:(SLContacts *)contacts{
    [self deleteContacts:contacts];
    [self addContacts:contacts];
}

- (void)deleteContacts:(SLContacts *)contacts{
    // 授权成功
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        NSMutableString *tempName = [NSMutableString string];
        if(contacts.lastName){
            [tempName appendFormat:@"%@", contacts.lastName];
        }
        if(contacts.middleName){
            [tempName appendFormat:@"%@", contacts.middleName];
        }
        if(contacts.firstName){
            [tempName appendFormat:@"%@", contacts.firstName];
        }
        
        NSString *name = [tempName copy];
        if(name.length){
            CFStringRef cfName = (__bridge CFStringRef)(name);
            CFArrayRef peopleArray = ABAddressBookCopyPeopleWithName(addressBook, cfName);
            if(peopleArray != NULL){
                for(CFIndex index = 0; index < CFArrayGetCount(peopleArray); index ++){
                    ABRecordRef record = CFArrayGetValueAtIndex(peopleArray, index);
                    ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(record, kABPersonPhoneProperty);
                    // 如果两者的电话数据不一样，则认为不是同一个联系人，继续下一个循环
                    if(contacts.phones.count != ABMultiValueGetCount(phones)){
                        continue;
                    }
                    // 是否可以删除的标志
                    BOOL isCanDelete = YES;
                    for(int i = 0; i < ABMultiValueGetCount(phones); i++){
                        NSString *type = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, i)));
                        NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, i));
                        SLContactsPhone *contactsPhone = contacts.phones[i];
                        // 如果有其中一个电话号码或者对应的标签不一样，则不允许删除
                        if(!([type isEqualToString:contactsPhone.type] && [phone isEqualToString:contactsPhone.phone])){
                            isCanDelete = NO;
                        }
                    }
                    
                    if(isCanDelete){
                        ABAddressBookRemoveRecord(addressBook, record, NULL);
                        ABAddressBookSave(addressBook, NULL);
                    }
                    CFRelease(phones);
                }
            }
            CFRelease(peopleArray);
        }
        CFRelease(addressBook);
    }
}

- (NSArray *)contactsWithPhone:(NSString *)phone{
    NSArray *allContacts = [self allContacts];
    NSMutableArray *contactsArray = [NSMutableArray array];
    for(int i = 0; i < allContacts.count; i ++){
        SLContacts *contacts = allContacts[i];
        if(contacts == nil){
            continue;
        }
        
        NSArray *phones = contacts.phones;
        if(phones == nil || phones.count == 0){
            continue;
        }
        
        for(int j = 0; j < phones.count; j ++){
            SLContactsPhone *contactsPhone = phones[j];
            if(contactsPhone == nil){
                continue;
            }
            
            NSRange range = [contactsPhone.phone rangeOfString:phone];
            if(range.location != NSNotFound){
                [contactsArray addObject:contacts];
                break;
            }
        }
    }
    return [contactsArray copy];
}

@end
