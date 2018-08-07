#import "ActCategory.h"

@implementation ActCategory

@dynamic categoryName, acts, categoryImage, detailViewImageName, emoji, colorR, colorB, colorG;

+ (NSString *)parseClassName {
    return @"ActCategory";
}

+ (ActCategory *)fetchCategoryOfName:(NSString *)catType  {
    PFQuery *query = [PFQuery queryWithClassName:@"ActCategory"];
    [query includeKey:@"categoryName"];
    [query includeKey:@"acts"];
    [query whereKey:@"categoryName" equalTo:catType];
    NSArray *cats = [query findObjects];
    return cats[0];
}

@end
