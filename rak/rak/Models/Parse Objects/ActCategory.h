#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ActCategory : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) PFFile *categoryImage;
@property (strong, nonatomic) NSString *detailViewImageName;

@property (nonatomic) CGFloat colorR;
@property (nonatomic) CGFloat colorG;
@property (nonatomic) CGFloat colorB;

+ (ActCategory *)fetchCategoryOfName:(NSString *)catType;

@end
