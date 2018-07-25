#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface Badge : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *badgeName;
@property (strong, nonatomic) NSString *badgeDescription;
@property (strong, nonatomic) PFFile *badgeImage;
@property (strong, nonatomic) NSString *badgeType;
@property (nonatomic) NSInteger value;

+ (Badge *)fetchBadgeOfType:(NSString *)badgeType withValueGreaterThan:(NSInteger)value;
@end
