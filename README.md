LMQExtension
============

Conversion between JSON and model

# Examples

### Model
```objc

@interface User : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (copy, nonatomic) NSNumber *sex;
@property (assign, nonatomic, getter=isSporter) BOOL sporter;
@property (strong, nonatomic) User *partner;
@property (strong, nonatomic) NSArray <User*>*friends;
@end

@implementation User
//标记模型中的数组中对象的类型
- (NSDictionary *)objectClassInArray
{
    return @{@"friends" : [User class]};
}

//在JSON和Model中相应的参数名不一致时进行替换
- (NSDictionary *)replacedKeyFromIvarName
{
    return @{@"partner" : @"companyPartner"};
}

@end

```
### JSON
```Objc

NSDictionary *companyPartner = @{ @"name" : @"li",
    @"icon" : @"icon2.png",
    @"age" : @24,
    @"height" : @"178",
    @"money" : @200,
    @"sex" : @(1),
};
    
NSDictionary *friend1 = @{ @"name" : @"zhao",
    @"icon" : @"icon3.png",
    @"age" : @22,
    @"height" : @"158",
    @"money" : @200,
    @"sex" : @(1),
};
    
NSDictionary *friend2 = @{ @"name" : @"zhang",
    @"icon" : @"icon4.png",
    @"age" : @27,
    @"height" : @"188",
    @"money" : @400,
    @"sex" : @(1),
};
    
NSArray *friends = @[friend1,friend2];

NSDictionary *dict = @{
    @"name" : @"Jack",
    @"icon" : @"icon.png",
    @"age" : @23,
    @"height" : @"168",
    @"money" : @100.9,
    @"sex" : @(1),
    @"sporter" : @"true",
    @"companyPartner":companyPartner,
    @"friends":friends
};

```
### JSON -> Model
```Objc
User *user = [User modelWithKeyValues:dict];
```
### Model -> JSON
```Objc
NSDictionary *dict = [user toDictionary];
```
### JSON array -> Model array
```Objc
NSArray *models = [User modelArrayWithDictArray:@[dict1,dict2]];
```
### Model array -> JSON array
```Objc
NSArray *dicts = [User dictArrayWithModelArray:@[user1,user2]];
```

### Coding

```objc
#import "LMQExtension.h"

@interface User : NSObject<NSCoding>
...
@end

@implementation User
CodingImplementation
@end
```

