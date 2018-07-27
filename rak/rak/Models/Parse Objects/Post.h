#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CustomUser.h"
#import "ParseUI.h"
#import "DateTools.h"

@interface Post : PFObject <PFSubclassing>

@property (strong, nonatomic) CustomUser * _Nullable author;
@property (strong, nonatomic) NSString * _Nullable caption;
@property (strong, nonatomic) PFFile * _Nullable image;
@property (nonatomic, strong) NSMutableArray * _Nullable likedBy;
@property (nonatomic, strong) NSNumber * _Nonnull likeCount;
@property (nonatomic, strong) NSMutableArray * _Nullable tweetedBy;
@property (nonatomic, strong) NSNumber * _Nonnull tweetCount;

+ (void)postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;

- (NSString *) creatingTimestamp;
- (BOOL) likedByCurrent;
- (BOOL) tweetedByCurrent;

@end
