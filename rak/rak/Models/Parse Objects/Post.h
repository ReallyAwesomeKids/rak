#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CustomUser.h"
#import "ParseUI.h"

@interface Post : PFObject <PFSubclassing>

@property (strong, nonatomic) CustomUser * _Nullable author;
@property (strong, nonatomic) NSString * _Nullable caption;
@property (strong, nonatomic) PFFile * _Nullable image;

+ (void)postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;

@end
