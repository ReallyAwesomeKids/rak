#import "Post.h"

@implementation Post

@dynamic author, caption, image, likedBy, likeCount;

+ (NSString *)parseClassName {
    return @"Post";
}

+ (void)postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Post *newPost = [Post new];
    newPost.author = (CustomUser *)[PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.likedBy = [[NSMutableArray alloc] init];
    newPost.image = [self getPFFileFromImage:image];
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

- (BOOL) likedByCurrent {
    return [self.likedBy containsObject: CustomUser.currentUser.objectId];
}

@end
