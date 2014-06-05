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
    // contacts应该得到的是一个真实存在的联系人，而非通过[[SLContacts alloc] init]创建，此处只是举例说明方法传入的参数类型
    SLContacts *contacts = [[SLContacts alloc] init];
    [addressBook updateContacts:contacts];
###6.删除一个联系人
    // contacts应该得到的是一个真实存在的联系人，而非通过[[SLContacts alloc] init]创建，此处只是举例说明方法传入的参数类型
    SLContacts *contacts = [[SLContacts alloc] init];
    [addressBook deleteContacts:contacts];
