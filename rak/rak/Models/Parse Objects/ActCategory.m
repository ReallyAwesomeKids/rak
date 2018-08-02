#import "ActCategory.h"

@implementation ActCategory

@dynamic categoryName, acts, categoryImage, detailViewImageName, colorR, colorB, colorG;

+ (NSString *)parseClassName {
    return @"ActCategory";
}

+ (ActCategory *)fetchCategoryOfName:(NSString *)catType  {
    PFQuery *query = [PFQuery queryWithClassName:@"ActCategory"];
    [query includeKey:@"categoryName"];
    [query includeKey:@"acts"];
    [query whereKey:@"categoryName" equalTo:catType];
    NSArray *cats = [query findObjects];
    NSLog(@"hi");
    NSLog(@"%@", cats[0]);
    return cats[0];
}

@end
