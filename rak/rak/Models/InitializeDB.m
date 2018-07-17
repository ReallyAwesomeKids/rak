//
//  InitializeDB.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "InitializeDB.h"
#import "Act.h"
#import "CustomUser.h"
#import "ActCategory.h"

@implementation InitializeDB

+ (void) initializeDatabase {
    //[self initializeActCategories];
    //[self initializeUser];
    //[self initializeActs];
}

+ (void)initializeUser {
     CustomUser *newUser = [CustomUser new];
     
     newUser.username = @"a";
     newUser.password = @"a";
     
     newUser.profileImage = [CustomUser getPFFileFromImage:[UIImage imageNamed:@"default.png"]];
     newUser.displayName = @"Ayy";
     newUser.location = @"Menlo Park";
     newUser.streak = 0;
     newUser.experiencePoints = 0;
     newUser.actsDone = @{};
     newUser.badges = [NSArray new];
     newUser.chosenActs = [NSArray new];
     
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error signing up: %@", error.localizedDescription);
        else {
            NSLog(@"success signing up");
        }
    }];
}

+ (void)initializeActs {
    NSArray *community = @[@"Buy food for a homeless person",
                           @"Have a conversation with a homeless person",
                           @"Serve at a homeless shelter",
                           @"Donate your old clothes",
                           @"Help an elderly person with their groceries",
                           @"Babysit for free",
                           @"Leave a letter of encouragement on someones window shield",
                           @"Plant a tree",
                           @"Start a fundraiser for a cause you're passionate about",
                           @"While you're out, compliment a parent on how well-behaved their child is",
                           @"Compliment someone to their boss"];
    
    NSArray *family = @[ @"Prepare a meal for a family member",
                         @"Call a family member and tell them you love them",
                         @"Call a family member and tell them you appreciate them"];
    
    NSArray *dating = @[@"Tell your partner how amazingly \"hot\" they are",
                        @"Tell your partner what a good hair day they’re having",
                        @"Tell your partners parents how talented your partner is at something",
                        @"Do the dishes for your partner",
                        @"Let your partner watch their show"];
    
    NSArray *friends = @[@"Slip a nice note in your friend's backpack",
                         @"Tell a friend you appreciate them",
                         @"Recommend a book to a friend",
                         @"Buy an inspirational book for a friend",
                         @"Frame your friend's favorite lyric or quote and give it to them with a nice note"];
    
    NSArray *work = @[ @"Bring donuts or other delicious sweets to work",
                       @"Sit for lunch with someone who is siting alone",
                       @"Sincerely compliment your boss",
                       @"Put sticky notes with positive slogans on the mirrors in your work restroom",
                       @"Send anonymous flowers to the receptionist at work",
                       @"Say thank you to your custodial staff"];
    
    NSDictionary *categories = @{@"Community" : community,
                                 @"Family" : family,
                                 @"Friends" : friends,
                                 @"Dating" : dating,
                                 @"Work" : work};
    
    for (NSString *key in categories) {
        NSArray *arr = [categories objectForKey:key];
        for (NSString *name in arr) {
            Act *act = [Act new];
            act.actName = name;
            act.pointsWorth = 1;
            act.category = key;
            [act saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error)
                    NSLog(@"error: %@", error.localizedDescription);
                else
                    NSLog(@"logged %@", act.actName);
            }];
        }
    }
}

+ (void)initializeActCategories {
    NSArray *cats = @[@"Community", @"Family", @"Friends", @"Dating", @"Work"];
    for (NSString *cat in cats) {
        
        ActCategory *category = [[ActCategory alloc] init];
        category.categoryName = cat;
        PFQuery *query = [PFQuery queryWithClassName:@"Act"];
        [query orderByAscending:@"actName"];
        [query whereKey:@"category" equalTo:cat];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable acts, NSError * _Nullable error) {
            category.acts = acts;
            [category saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"successfully saved %@", cat);
                }
            }];
        }];
        
    }
}

@end
