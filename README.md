parse-dashboard --appId rak_id --masterKey rak_key --serverURL https://random-acts-of-kindness.herokuapp.com/parse

# Team Project - *RAK*

**RAK** is an app where users can do random acts of kindness and build kind habits.

## Considerations

What is your product pitch?
- Incentivizing people to do more kind deeds more often

Who are the key stakeholders for this app?
- People who want to become more positive and kind
- People will use the app to build habits of doing acts of kindness

What are the core flows?
- 5 tabs: Homepage, Acts of Kindness Catalogue, Search, Local Needs, Timeline
  1. **Homepage**: User sees the acts of kindness that they choose to work on. Can remove acts from their homepage and add acts to their homepage using the acts of kindness catalogue. User presses a "complete" button on an act when they did it, and the progress level of the act is updated. Clicking on the task opens up a detail view showing more information about the act and the user's progress.
  2. **Acts of Kindness Catalogue**: Contains all acts of kindness, categorized by themes like "Friends" and "Family".
  3. **Search**: User can search for users and view their profiles
  4. (Extended) **Local Needs**: User can view needs in their community using a map with pins. Tapping on a pin allows user to see more details about the need. iUser can add pins to the map.
  5. (Extended) **Timeline**: A public feed showing posts from everyone. User can make posts sharing their experiences relating to acts of kindness they have done or have received.
- User has a profile page showing their name, profile picture, a streak indicating how many days in a row they have done an act of kindness, and badges representing milestones they've hit.

What will your final demo look like?
- Show homepage with some acts of kindness on it. Go to Acts of Kindness Catalogue and add an act to the homepage. Click on an act to see the detail view. Complete an act. View Local Needs map, choose a pin and view its details. Go to the profile and view the daily streak and badges. Go to timeline and make a post about an act of kindness you did.

What mobile features do you leverage?
- **Convenience and mobility of phones**: Everyone always has their phone, so it's easy to open the app and mark the act of kindness you completed right after you did it
- **Maps**: The Local Needs tab uses a map to show needs in the community

What are your technical concerns?
- Working with complex database objects (ex. dictionary)
- Avoiding and resolving merge conflicts

## User Stories

### Core User Stories
- Tableview of all random acts of kindness that the user can do
  - Functionality: "complete" a task
- Detail view of each task
  - Shows more detail about the task
  - Shows user's progress
  - Difficulty level
- Database to store user information
  - account info
  - personal info (name, image)
  - progress on the random acts of kindness challenges
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
- [x] (Haley) User profile page
  - [x] Name label
  - [x] Static profile picture and location label temporarily
  - [x] Functional streak label
  - [x] Level and level progress labels update correctly
- [x] (Haley) Detail view of each task
  - [x] Shows log of when user completed it
- [x] Searching for users tab
- [x] Badges on profile page
- [x] Map view
  - [x] See pins from db
  - [X] Make pins
  - [X] Search for locations with Foursquare API
  - [x] Select pin to see detail page
- [x] (Gustavo) Basic timeline
  - [x] See other people's posts
  - [x] Create Compose VC
  - [x] Make your own posts
  - [x] Refresh Control

## Week 2 - 7/23/18 - 7/27/18
- [x] (Haley) In-app pop up notifications when did act, level up, earned badge, etc...
  - [x] After an act is completed, user can click a "share" button that will share to the timeline.
  - [x] After user achieves a new level or earns new badge, they can share the achievement to the timeline
- [x] (Everyone) Determine color scheme
- [x] (Gustavo) Timeline
  - [x] Clicking at Profile picture leads to the User profile
  - [x] Supporting Images
  - [x] Share to Twitter
  - [x] Toggle button functionality
  - [x] Designing it beautifully
- [x] (Gustavo) Cleaning everyone's code (spaces at function declation, adding comments, deleting irregular newlines, etc)

## Week 3 - 7/30/18 - 8/3/18
- [ ] (Everyone) App VC: Change font/emoji
- [x] (Gustavo) Database: Assign points to tasks
- [x] (Gustavo) Timeline VC: 
  - [x] (Gustavo) Images fade in
  - [x] (Gustavo) Smiley button 
  - [x] (Gustavo) UIActivityController for Twitter functionality (replacing tweet button)
- [x] (Gustavo) Compose VC: redesign
- [x] (Gustavo) Home VC: 
  - [x] (Gustavo) When pressing check button, color changes
  - [x] (Gustavo) Daily challenges check button functionality
- [x] (Gustavo/Haley) Sign up VC: sign up page
- [x] (Gustavo/Haley) Act Detail VC: Act detail view needs a lot of work
- [x] (Haley) Login VC: Login page redesign
- [x] (Haley) Profile VC: Profile location is actually accurate
- [x] (Haley) Profile VC: redesign
- [x] (Halima) Map VC: description page design; remove placeholder text
- [x] (Halima) Map VC: When searching for location, pop up keyboard automatically
- [ ] (Halima) Map VC: view is centered on current/user's location
- [x] (Halima) Search Page VC: Search page redesign
- [ ] (Halima) Categories page design
  - [x] Category VC: If the task is already on the homepage you wanna have a Minus (-) instead of the checkmark
  - [ ] Category VC: Carousel 
- [ ] (Halima) Add acts from map to homepage; being able to complete them
- [ ] () User can add their own acts of kindness
- [ ] () Design launch screen and logo

## Week 4 - 8/6/18 - 8/10/18

## Week 5 - 8/13/18 - 8/17/18

## Bugs found that need to be solved
- [x] (Gustavo) clicking checkmark button at Home [Home VC]
  - [ ] Gustavo) clicking checkmark button at Daily Challenge [Home VC]
- [x] (Gustavo) Refresh control breaks when user tries to load page when number of posts is 0 [Timeline VC]
- [x] user should not be able to add the same act multiple times to db [Category VC]
- [ ] () When timeline loads, images are in the level-up height/width; only get normal size when refreshed [Timeline VC]


## Extended Functionality Ideas
- [ ] User can write their own acts of kindness

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
