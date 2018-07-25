#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Act : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *actName;
@property (nonatomic) NSInteger pointsWorth;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSDate *dateLastFeatured;

- (void)updateDateLastFeatured;

@end
