#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ImageToFileConversion : NSObject

+ (PFFile *)getPFFileFromImage:(UIImage *)image;

@end
