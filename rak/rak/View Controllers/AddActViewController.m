//
//  AddActViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 8/2/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "AddActViewController.h"
#import "ActCategory.h"
#import "Act.h"

@interface AddActViewController ()

@property (weak, nonatomic) IBOutlet UITextField *categoryName;
@property (weak, nonatomic) IBOutlet UITextField *userActName;
@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *acts;

- (IBAction)didTapDone:(id)sender;

@end

@implementation AddActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}

- (IBAction)didTapDone:(id)sender {
    [self addActWithName:self.userActName.text
              withPoints:1
      inCategoryWithName:self.categoryName.text];
}

- (void)addActWithName:(NSString *)name
            withPoints:(NSInteger)points
    inCategoryWithName:(NSString *)categoryName {
    Act *actToBeAdded = [Act new];
    actToBeAdded.actName = name;
    actToBeAdded.pointsWorth = points;
    actToBeAdded.category = categoryName;
    
    [actToBeAdded saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error saving user act");
    }];
    
    // Adds new act to the its Act Category on Parse
    ActCategory *actCat = [ActCategory fetchCategoryOfName:self.categoryName.text];
    [actCat.acts arrayByAddingObject:actToBeAdded];
    NSMutableArray *actCatMutable = [self createMutableArray:actCat.acts];
    [actCatMutable addObject:actToBeAdded];
    NSArray *array = [actCatMutable copy];
    actCat.acts = array;
    
    // Updates Act Object
    [actToBeAdded saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
            NSLog(@"%@", error.localizedDescription);
    }];
    // Updates Category Object
    [actCat saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error saving user act to category");
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
