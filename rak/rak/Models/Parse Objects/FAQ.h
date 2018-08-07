#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface FAQ : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *text; // Text content of the question
@property (strong, nonatomic) NSString *answer; // Text content of the question

@end
