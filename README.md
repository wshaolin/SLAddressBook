SLAddressBook
=============
iOS通讯录访问操作封装，全部封装为objective-c对象，不用再操作底层的C语言代码.

使用方法：
=============
###1.获取所有联系人，返回数组，数组中的元素类型为SLContacts
    SLAddressBook *addressBook = [SLAddressBook addressBook];
    NSArray *allContacts= [addressBook allContacts];
###2.根据名称查找联系人，返回数组，数组中的元素类型为SLContacts
    SLAddressBook *addressBook = [SLAddressBook addressBook];
    NSArray *contacts= [addressBook contactsWithName:@"name"];
###3.根据电话查找联系人，返回数组，数组中的元素类型为SLContacts
    NSArray *contacts= [addressBook contactsWithPhone:@"18600232323"];
###4.向通讯录中增加一个联系人
    SLContacts *contacts = [[SLContacts alloc] init];
    contacts.firstName = @"三";
    contacts.lastName = @"张";
    SLContactsPhone *phone = [[SLContactsPhone alloc] init];
    phone.type = kSLContactsPhoneTypePhoneMain;
    phone.phone = @"18600232323";
    contacts.phones = @{phone};
    [addressBook addContacts:contacts];
###5.修改通讯录中一个联系人的资料，如果修改的联系人在通讯录中没有时会增加这个联系人到通讯录中
    // contacts应该得到的是一个真实存在的联系人，而非通过[[SLContacts alloc] init]创建
    // 此处只是举例说明方法传入的参数类型
    SLContacts *contacts = [[SLContacts alloc] init];
    [addressBook updateContacts:contacts];
###6.删除一个联系人
    // contacts应该得到的是一个真实存在的联系人，而非通过[[SLContacts alloc] init]创建
    // 此处只是举例说明方法传入的参数类型
    SLContacts *contacts = [[SLContacts alloc] init];
    [addressBook deleteContacts:contacts];
###7.其他类型中的type（对应原来的Label或者key，视具体情况而定）值请使用SLConstants.h中的常量判断，常量如下：
    // SLContacts中通用的常量
    NSString *const kSLContactsTypeWork = @"work";
    NSString *const kSLContactsTypeHome = @"home";
    NSString *const kSLContactsTypeOther = @"other";

    // SLContacts的URL类型的常量(个人主页)
    NSString *const kSLContactsURLTypeHomePage = @"home page";

    // SLContacts的日期类型的常量(周年)
    NSString *const kSLContactsDateTypeAnniversary = @"anniversary";

    // SLContacts电话类型的常量
    NSString *const kSLContactsPhoneTypePhoneMobile = @"mobile";
    NSString *const kSLContactsPhoneTypePhoneIPhone = @"iPhone";
    NSString *const kSLContactsPhoneTypePhoneMain = @"main";
    NSString *const kSLContactsPhoneTypePhoneHomeFax = @"home fax";
    NSString *const kSLContactsPhoneTypePhoneWorkFax = @"work fax";
    NSString *const kSLContactsPhoneTypePhoneOtherFax = @"other fax";
    NSString *const kSLContactsPhoneTypePhonePager = @"pager";

    // SLContacts即时信息的类型常量
    NSString *const kSLContactsInstantMessageServiceTypeYahoo = @"Yahoo";
    NSString *const kSLContactsInstantMessageServiceTypeJabber = @"Jabber";
    NSString *const kSLContactsInstantMessageServiceTypeMSN = @"MSN";
    NSString *const kSLContactsInstantMessageServiceTypeICQ = @"ICQ";
    NSString *const kSLContactsInstantMessageServiceTypeAIM = @"AIM";
    NSString *const kSLContactsInstantMessageServiceTypeQQ = @"QQ";
    NSString *const kSLContactsInstantMessageServiceTypeGoogleTalk = @"GoogleTalk";
    NSString *const kSLContactsInstantMessageServiceTypeSkype = @"Skype";
    NSString *const kSLContactsInstantMessageServiceTypeFacebook = @"Facebook";
    NSString *const kSLContactsInstantMessageServiceTypeGaduGadu = @"GaduGadu";

    // SLContacts相关名称类型的常量
    NSString *const kSLContactsRelatedNameTypeFather = @"father";
    NSString *const kSLContactsRelatedNameTypeMother = @"mother";
    NSString *const kSLContactsRelatedNameTypeParent = @"parent";
    NSString *const kSLContactsRelatedNameTypeBrother = @"brother";
    NSString *const kSLContactsRelatedNameTypeSister = @"sister";
    NSString *const kSLContactsRelatedNameTypeChild = @"child";
    NSString *const kSLContactsRelatedNameTypeSpouse = @"spouse";
    NSString *const kSLContactsRelatedNameTypePartner = @"partner";
    NSString *const kSLContactsRelatedNameTypeAssistant = @"assistant";
    NSString *const kSLContactsRelatedNameTypeManager = @"manager";

    // SLContacts社交类型的常量
    NSString *const kSLContactsSocialProfileServiceTypeTwitter = @"twitter";
    NSString *const kSLContactsSocialProfileServiceTypeSinaWeibo = @"sinaweibo";
    NSString *const kSLContactsSocialProfileServiceTypeGameCenter = @"gamecenter";
    NSString *const kSLContactsSocialProfileServiceTypeFacebook = @"facebook";
    NSString *const kSLContactsSocialProfileServiceTypeMyspace = @"myspace";
    NSString *const kSLContactsSocialProfileServiceTypeLinkedIn = @"linkedin";
    NSString *const kSLContactsSocialProfileServiceTypeFlickr = @"flickr";
