#import "InitializeDB.h"
#import "Act.h"
#import "CustomUser.h"
#import "ActCategory.h"
#import "ImageToFileConversion.h"
#import "DateFunctions.h"
#import "Post.h"
#import "Badge.h"

@implementation InitializeDB

+ (void)initializeDatabase {
    //[self initializeUser];
    //[self initializeActs];
    //[self initializeActCategories];
    //[self updateActs];
    //[self initializeBadges];

}

+ (void)updateActs {
    PFQuery *challengeQuery = [Act query];
    [challengeQuery includeKey:@"category"];
    [challengeQuery whereKey:@"category" equalTo:@"Daily Challenges"];
    [challengeQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (Act *act in objects) {
            act.dateLastFeatured = nil;
            [act saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error)
                    NSLog(@"error saving acts");
                else
                    NSLog(@"success saving acts");
            }];
        }
    }];
}

+ (void)initializeUser {
    CustomUser *newUser = [CustomUser new];
    
    newUser.username = @"a";
    newUser.password = @"a";
    
    newUser.profileImage = [ImageToFileConversion getPFFileFromImage:[UIImage imageNamed:@"default.png"]];
    newUser.displayName = @"Ayy";
    newUser.location = @"Menlo Park";
    newUser.streak = 0;
    newUser.dateLastDidAct = nil;
    newUser.experiencePoints = 0;
    newUser.actHistory = @{};
    newUser.amountActsDone = 0;
    newUser.overallBadges = @[];
    newUser.streakBadges = @[];
    Act *act = [Act new];
    act.actName = @"Testing the database";
    act.pointsWorth = 1;
    act.category = @"fake category";
    
    newUser.chosenActs = @[act];
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error signing up: %@", error.localizedDescription);
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
    NSArray *dailyChallenges = @[@"Do a favor without asking for anything in return",
                                 @"Buy flowers and hand them out on the street",
                                 @"Say \"I love you\" to someone you love",
                                 @"Connect two people you believe should know each other",
                                 @"Send someone a hand written note of thanks",
                                 @"Send someone a small gift anonymously",
                                 @"Tweet or Facebook message a genuine compliment to three people right now",
                                 @"IM or email that person you're afraid to talk to because you don't want to bother them"];
    
    NSDictionary *categories = @{@"Community" : community,
                                 @"Family" : family,
                                 @"Friends" : friends,
                                 @"Dating" : dating,
                                 @"Work" : work,
                                 @"Daily Challenges" : dailyChallenges
                                 };
    
    for (NSString *key in categories) {
        NSArray *arr = [categories objectForKey:key];
        for (NSString *name in arr) {
            Act *act = [Act new];
            act.actName = name;
            act.pointsWorth = 1;
            act.category = key;
            [act saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error)
                    NSLog(@"error initializing acts: %@", error.localizedDescription);
            }];
        }
    }
}

+ (void)initializeActCategories {
    NSArray *cats = @[@"Community", @"Family", @"Friends", @"Dating", @"Work", @"Daily Challenges"];
    for (NSString *cat in cats) {
        
        ActCategory *category = [[ActCategory alloc] init];
        category.categoryName = cat;
        category.categoryImage = [ImageToFileConversion getPFFileFromImage:[UIImage imageNamed:cat]];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Act"];
        [query orderByAscending:@"actName"];
        [query whereKey:@"category" equalTo:cat];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable acts, NSError * _Nullable error) {
            category.acts = acts;
            [category saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"error initializing category: %@", error.localizedDescription);
                }
            }];
        }];
        
    }
}

+ (void)initializeBadges {
    NSArray *overalls = @[@1, @10, @50, @100, @250, @500, @1000];
    NSArray *streak = @[@7, @30, @100, @365];
    
    for (NSNumber *value in overalls) {
        Badge *badge = [Badge new];

        NSInteger val = [value integerValue];
        NSString *desc = [NSString stringWithFormat:@"Achieved a %ld day streak", val];
        badge.badgeDescription = desc;
        badge.value = val;
        badge.badgeType = @"Overall";
        badge.badgeName = @"def";
        badge.badgeImage = [ImageToFileConversion getPFFileFromImage:[UIImage imageNamed:@"default.png"]];
        [badge saveInBackground];
    }

    
    for (NSNumber *value in streak) {
        Badge *badge = [Badge new];
        
        NSInteger val = [value integerValue];
        NSString *desc = [NSString stringWithFormat:@"Achieved a %ld day streak", val];
        badge.badgeDescription = desc;
        badge.value = val;
        badge.badgeType = @"Streak";
        badge.badgeName = @"def";
        badge.badgeImage = [ImageToFileConversion getPFFileFromImage:[UIImage imageNamed:@"default.png"]];
        [badge saveInBackground];
    }
}

@end
