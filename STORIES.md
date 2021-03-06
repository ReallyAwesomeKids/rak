## User Stories

### Core User Stories
- Tableview of all random acts of kindness that the user can do
- Functionality: "complete" a task
- Detail view of each task
- Shows more detail about the task
- Shows user's progress
- Difficulty level
- Database to store user information
- Account info
- Personal info (name, image)
- Progress on the random acts of kindness challenges
- Profile page showing the user's info and acts of kindness history
- Profile image
- Progress report showing how many tasks they've done, daily streak record, etc.
- Search for users and view their profiles
- Invite/challenge friend via text message/email

### Extended User Stories (in order of priority)
- Achievements for hitting milestones
- Streaks (1 week, 1 month, 1 year)
- No. of acts (First act, 100 acts)
- Inviting friends
- Categorizing acts
- List of categories and being able to click on them to see all tasks in that category
- Search for categories
- Making a featured act of the day and having a separate streak for that
- Sharing to Facebook/Instagram
- Make a timeline where users can share stories about nice things they've done or have have happened to them
- First, text posts
- Photos, images
- Liking
- Commenting
- Location-/Community-based challenges using maps
- Users can add opportunities on the map for acts of kindness (ex. food drives, libraries, food pantries, etc.)
- Users can see opportunities in their area based on their location
- Select pins on map to see more details about the opportunity
- Search locations and find opportunities there

## Sprints

### Week 1 - 7/16/18 - 7/20/18

CORE
- [x] (Everyone) Redo wireframes with details
- [x] (Everyone) Brainstorming different acts of kindness and categoriezing them
- [x] (Everyone) Datebase design from scratch (figuring out what kind of Parse objects we need and how to structure it)
- [x] (Gustavo) Homepage with selected tasks on it
- [x] (Gustavo) Implementing a refresh control to load data
- [x] (Gustavo) Done functionality on a cell
- [x] (Gustavo) Removing tasks from your homepage 
- [x] (Gustavo) Swipable cells instead of the close button
- [X] (Halima) Having task categories and lists of tasks in each category
- [X] (Halima) Adding tasks to your homepage via the categorized task lists ^
- [x] (Haley) Setting up database objects
- [x] (Haley) User profile page
- [x] Name label
- [x] Static profile picture and location label temporarily
- [x] Functional streak label
- [x] Level and level progress labels update correctly
- [x] (Haley) Detail view of each task
- [x] Shows log of when user completed it
- [x] (Halima) Searching for users tab
- [x] (Haley) Badges on profile page
- [x] (Gustavo) Basic timeline
- [x] See other people's posts
- [x] Create Compose VC
- [x] Make your own posts
- [x] Refresh Control

## Week 2 - 7/23/18 - 7/27/18
- [x] (Haley) In-app pop up notifications when did act, level up, earned badge, etc...
- [x] After an act is completed, user can click a "share" button that will share to the timeline.
- [x] After user achieves a new level or earns new badge, they can share the achievement to the timeline
- [x] (Haley) Badges show description when tapped
- [x] (Everyone) Determine color scheme
- [x] (Gustavo) Timeline
- [x] Clicking at Profile picture leads to the User profile
- [x] Supporting Images
- [x] Share to Twitter
- [x] Toggle button functionality
- [x] Designing it beautifully
- [x] (Gustavo) Cleaning everyone's code (spaces at function declation, adding comments, deleting irregular newlines, etc)
- [x] (Halima) Map view
- [x] See pins from db
- [X] Make pins
- [X] Search for locations with Foursquare API
- [x] Select pin to see detail page
- [x] (Halima) Categories page redesign

## Week 3 - 7/30/18 - 8/3/18
- [x] (Everyone) App VC: Change font/emoji
- [x] (Gustavo) Database: Assign points to tasks
- [x] (Gustavo) Timeline VC: 
- [x] (Gustavo) Images fade in
- [x] (Gustavo) Smiley button 
- [x] (Gustavo) UIActivityController for Twitter functionality (replacing tweet button)
- [x] (Gustavo) Compose VC: redesign
- [x] (Gustavo) Home VC: 
- [x] (Gustavo) When pressing check button, color changes
- [x] (Gustavo) Daily challenges check button functionality
- [x] (Gustavo) User can add their own acts of kindness
- [x] (Gustavo) Settings VC initial work:
- [x] (Gustavo) Migrate functionality from twitter & log-out there
- [x] (Gustavo) Edit profile picture, city, etc
- [x] (Gustavo/Haley) Sign up VC: sign up page
- [x] (Gustavo/Haley) Act Detail VC: Act detail view needs a lot of work
- [x] (Haley) Login VC: Login page redesign
- [x] (Haley) Profile VC: redesign
- [x] (Halima) Map VC: description page design; remove placeholder text
- [x] (Halima) Map VC: When searching for location, pop up keyboard automatically
- [x] (Haley) Map VC: view is centered on current/user's location
- [x] (Halima) Search Page VC: Search page redesign
- [x] (Haley) Categories page design
- [x] Category VC: If the task is already on the homepage you wanna have a Minus (-) instead of the checkmark
- [x] (Haley) Move map into categories
- [x] (Haley) Remove full description view from map and put description on annotations instead
- [x] (Haley) Add acts from map to homepage; being able to complete them
- [x] (Haley) On homepage if there are no acts then theres a button to take you to the categories
- [x] (Haley) Walkthrough

## Week 4 - 8/6/18 - 8/10/18
- [x] (Gustavo) Settings page:
- [x] (Gustavo) Account page
- [x] (Gustavo) About page
- [x] (Gustavo) Help page
- [x] (Gustavo) Friends page
- [x] (Gustavo) Fetch all contacts from the user and display them
- [x] (Gustavo) Allow the user to invite the contacts displayed through email
- [x] (Gustavo's brother) Design launch screen and logo
- [x] (Halima) Homepage redesign:
- [x] (Haley) Add image/icon to acts
- [x] (Halima) Add points and/or amount of times done act to home
- [x] (Halima) Header over the chosen acts
- [x] (Halima) Level progress in the notification after completing an act
- [x] (Haley) Get rid of act detail view
- [x] (Haley) Daily challenge hides after completion
- [x] (Haley) Category VC: Carousel 
- [x] (Haley) Search for acts
- [x] (Haley) View all acts page
- [x] (Haley) Fixed daily challenge bug so that it will change daily

## Week 5 - 8/13/18 - 8/17/18

## Bugs/Design changes that need to be solved
- [x] (Gustavo) Clicking checkmark button at Home [Home VC]
- [x] (Gustavo) Clicking checkmark button at Daily Challenge [Home VC]
- [x] (Gustavo) Refresh control breaks when user tries to load page when number of posts is 0 [Timeline VC]
- [x] (Halima) user should not be able to add the same act multiple times to db [Category VC]
- [x] (Haley) If you add an act, go to home, delete it, and go back to categories, the button is still -, not +
- [x] (Haley) Map annotations are cut off
- [x] (Gustavo) Delete View All
- [x] (Gustavo) Take off select property of tableview in category
- [x] (Gustavo) Once you post in the timeline it automatically refreshes
- [x] (Halima) Daily challenges when it is done should have a header view saying it is done
- [x] (Haley) When user adds own act should be refreshed at category automatically
- [x] (Gustavo) Add act view to category as in Home as well
- [x] (Gustavo) Make search bar color in all VCs match the top bar
- [x] (Gustavo) Change trophy at at Profile, change "badges" font and color, change progress bar thickness and border color, center name of the user
- [x] (Haley) Search should be able to exit keyboard
- [x] (Haley) Move walkthrough to the first page
- [x] (Halima + Haley) The same act can be added multiple times to homepage and the Plus and Minus no longer working properly
- [x] (Halima) Message says the wrong level when you complete an act

## Extended Functionality Ideas
- [x] (Gustavo) User can write their own acts of kindness
- [ ] Leadership board

## Video Walkthrough for Thursday

1. Open app -> click sign-up -> make account
2. Show walkthrough -> go through walkthrough -> click got it
3. At homepage, click at choose acts -> flip through categories -> add some acts
4. Stop at map one, click view map -> click on pin -> add one -> Make own pin -> add description -> find your own pin and add home -> go back home
5. Add your own act >but don't show them<
6. Do one of the acts -> unlock innaugural badge -> click share -> add "I'm so excited" -> post -> scroll down timeline
7. Say "if i had my phone I could share to twitter, facebook, whatsapp, etc"
8. Make your own post -> see post
9. Check someone's profile (pls do Gustavo)
10. "I wonder who else is there" -> go to search


## Database Schema
- User
- Username (NSString)
- Password (NSString)
- Display name (NSString)
- Location (NSString)
- Streak (NSInteger)
- Date the user last completed an act (for streak) (NSDate)
- Total experience points (NSInteger)
- Amount of acts done (NSInteger)
- History of acts done (NSDictionary: {ActObjectId: [NSDate, NSDate, ...], ...})
- Streak-type badges (NSArray of Badges)
- Overall-acts-done-type badges (NSArray of Badges)

- Act
- Name (NSString)
- How many EXP points it's worth (NSInteger)
- Category it's under (NSString)
- (for Daily Challenge Category only) Date last featured (NSDate)

- Act Category
- Name (NSString)
- Image (PFFile)
- Acts that fall under it (NSArray of Acts)

- Badge
- Name (NSString)
- Badge icon (UIImage)
- Badge description (NSString)
- Badge category/type (NSString)
- Associated numerical value (ex. 1 week streak badge has value of 7) (NSInteger)

- Timeline post
- Author (CustomUser)
- Post text (NSString)
- Post image (PFFile)
- Liked by who (NSArray of CustomUsers)
- Like count (NSInteger)

- Map Pin
- Latitude (NSNumber)
- Longitude (NSNumber)
- Location name (NSString)
- Description (NSString)

