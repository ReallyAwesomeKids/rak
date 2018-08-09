#import <Foundation/Foundation.h>

#import <Parse/Parse.h>
#import "Act.h"
#import "Badge.h"

@protocol CustomUserDelegate <NSObject>

- (void)userDidGetNewBadge:(Badge *)badge;
- (void)userDidLevelUpTo:(NSInteger)level;

@end

@interface CustomUser : PFUser <PFSubclassing>

// User information
@property (strong, nonatomic) PFFile *profileImage;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSString *location;

// Acts
@property (nonatomic) NSInteger streak;
@property (strong, nonatomic) NSDate *dateLastDidAct;
@property (nonatomic) NSInteger experiencePoints;
@property (strong, nonatomic) NSDictionary *actHistory;
@property (nonatomic) NSInteger amountActsDone;
@property (nonatomic, assign) BOOL hasCompletedDailyChallenge;
@property (strong, nonatomic) NSDate *dateLastDidDailyChallenge;

// Badges
@property (strong, nonatomic) NSArray *overallBadges;
@property (strong, nonatomic) NSArray *streakBadges;

// Array populating homepage
@property (strong, nonatomic) NSArray *chosenActs;

@property (weak, nonatomic) id<CustomUserDelegate> delegate;

- (void)userDidCompleteAct:(Act *)act;

- (void)updateDailyStreak;

- (void)saveChangesInUserData;

- (BOOL)userDidDailyChallengeToday;

- (BOOL)actIsInChosenActs:(Act *)act;
- (void)removeActsFromChosenActs:(Act *)act;

@end
