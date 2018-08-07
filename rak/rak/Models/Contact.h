#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (strong, nonatomic) NSString *givenName;
@property (strong, nonatomic) NSString *familyName;
@property (strong, nonatomic) NSMutableArray *phoneNumbers;
@property (strong, nonatomic) NSMutableArray *emailAddresses;

@end
