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

### Week 1

CORE
- [x] (Everyone) Redo wireframes with details
- [x] (Everyone) Brainstorming different acts of kindness and categoriezing them
- [x] (Everyone) Datebase design from scratch (figuring out what kind of Parse objects we need and how to structure it)
- [x] (Gustavo) Homepage with selected tasks on it
- [x] (Gustavo) Done functionality on a cell
- [ ] (Gustavo) Removing tasks from your homepage by DetailsVC
- [X] (Halima) Having task categories and lists of tasks in each category
- [X] (Halima) Adding tasks to your homepage via the categorized task lists ^
- [x] (Haley) User profile page
  - [x] Name label
  - [x] Static profile picture and location label temporarily
  - [x] Functional streak label
  - [x] Level and level progress labels update correctly
- [ ] (Haley) Detail view of each task

EXTENDED
- [ ] Design launch screen and logo
- [ ] Determine color scheme
- [ ] (Gustavo) Homepage notifications when button clicked "done"
- [ ] (Gustavo) Swipable cells instead of the button done



### Week 2
- [ ] Searching for users tab
- [ ] Invite/challenge friend via text message/email
- [ ] Badges on profile page
- [ ] Timeline
  - [ ] See other people's posts
  - [ ] Make your own posts
  - [ ] Share to Facebook
  - [ ] Share to Twitter
  
### Week 3
- [ ] Map view
  - [ ] See pins from db
  - [ ] Make pins
  - [ ] Search for locations with Foursquare API
  - [ ] Select pin to see detail page

## Database Schema
- User
  - Username (NSString)
  - Password (NSString)
  - Display name (NSString)
  - Location (NSString)
  - Streak (NSInteger)
  - Total experience points (EXP) (NSInteger)
  - History of acts done (NSDictionary: {ActObjectId: [NSDate, NSDate, ...], ...})
  - Badges/achievements (NSArray)
  
- Act
  - Name (NSString)
  - How many EXP points it's worth (NSInteger)
  - Category it's under (NSString)

- Badge
  - Name (NSString)
  - Badge icon (UIImage)
  - Badge description (NSString)
  
- ExperiencePointsToLevelConverter
  - Conversion chart between level and points needed to complete level (NSDictionary: {@"1" : 100, ...}
