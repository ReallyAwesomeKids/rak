#import "ImageToFileConversion.h"

@implementation ImageToFileConversion


+ (PFFile *)getPFFileFromImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
