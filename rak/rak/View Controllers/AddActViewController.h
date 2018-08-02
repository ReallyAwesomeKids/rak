//
//  AddActViewController.h
//  rak
//
//  Created by Gustavo Coutinho on 8/2/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"

@interface AddActViewController : UIViewController

+ (Act *)addActWithName:(NSString *)name
            withPoints:(NSInteger)points
    inCategoryWithName:(NSString *)categoryName;

@end
