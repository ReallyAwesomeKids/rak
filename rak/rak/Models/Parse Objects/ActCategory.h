#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ActCategory : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) PFFile *categoryImage;

@end
