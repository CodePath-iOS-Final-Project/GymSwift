Original App Design Project - README Template
===

#  GymSwift 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

Our plan is to create an app for college students to hold them accountable so that they can stay on a healthy track and workout. We are going to do this by building an app to help them find a workout partner for a quick workout around the campus/neighborhood, so that they are held accountable. 

### App Evaluation

- **Category:** Fitness/Social Networking
-  **Mobile:** The prototype would be for iOS and there would be no camera accessibility (Uses camera roll and uploads). Functionality would not be limited to iOS but it would eventually expand to Android and PC. 
- **Story:** Allows users to find a workout partner and have somebody to hold them accountable for a healthy lifestyle. Students can stick to workout plans because their "partner" will keep them in check. They can organize their fitness journey alongside others that share the same interests in fitness. 
- **Market:** Provides an exciting match-up experience for students from all diverse backgrounds and helps them stay in shape. Futhermore, students with tight budgets that can't really afford to join a gym will have an accountability buddy that will help them to stay motivated. 
- **Habit:** The app's habit-forming quality is that bonds are formed and users would feel as if they need to continually keep tabs on their partners. The accountability section would be easy to use and fun to navigate because of its sleek UI/UX. 
- **Scope:** College students that want to get back to working out and meeting new people, especially after COVID limited in-person contact. Ensure safety for women and utilize background checks to make sure that they are protected against those who have malintent. Over time, it could expand to working professionals who lost the will to stay in shape. Cross-platform functionality would be available in the future.  

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can log in and log out
* Users set, change, remove profile photo
* User can pull to refresh
* Infinite scroll
* User stays logged in across restarts
* User can view comments 
* Users can add comment
* Users profile picture is shown.

**Optional Nice-to-have Stories**


* Users in the same common interest group have a chat window to get to know each other, with the ability to skip users and unmatch.  
* Private Chat Messages
* Light mode and dark mode features.
* Tag your workout partner(s). 


### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their editable profile page.  
   
* Profile Screen
   * Allows user to upload a photo and fill in info that is interesting to them and others. 
* Sports/Activity Selection Screen
   * Allows user to select a sport/activity that they want to be part of. 
* Accountability Screen 
    * Allow users to interact with GymSwift users and post progress and include messages of encouragement.
* Settings Screen
    * People can set app notification settings, change profile pic, update their preferred workout and light/dark mode feature.  
* Workout Journal Screen
    * People can jot their notes for their workouts and create new posts as well as delete any existing posts. 



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Accountability selection
* Profile
* Settings

Optional:

* Preference Algorithms 

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* Accountability Partner Selection -> Jumps to Messages/Chat
* Profile -> Text field to be modified
* Settings -> Toggle settings
 

## Wireframes

![](https://i.imgur.com/WYiR1LL.jpg)
![](https://i.imgur.com/a/i9WlI7t.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models


| Property | Type | Description |
| -------- | -------- | -------- |
|   objectId   |  String  | unique id for the user post (default field)    |
| user | Pointer to User | image user
|address | String | location marked on the map
|     image |   File |    image that user posts |
|     caption |  String  |   image caption by author  |
|     exerciseTypeID|  String  |  unique id for the exercise post (default field)    ||    |     |
|    commentsCount  | Number   |   number of comments that has been posted to an image  |
|    createdAt  |  DateTime  |  date when post is created (default field)   | |
|  updatedAt    |    DateTime|   date when post is last updated (default field)  |




### Networking
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update exercise status 

- Accountability Screen
    - (Read/GET) Query all posts where user and user's group as author
        ```swift 
        let query = PFQuery(className:"Post")
        query.whereKey("author", equalTo:"currentUser")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
            // Log details of the failure
              print(error.localizedDescription)
            } else if let objects = objects {
            // The find succeeded.
              print("Successfully retrieved \(objects.count) scores.")
            // Do something with the found objects
              for object in objects {
              print(object.objectId as Any)
            }
          }
        }
        ```
    - (Create/POST) Create a new post
    - (Create/POST) Create a new like on a post
    - (Delete) Delete an existing like
    - (Create/POST) Create a new comment on a post
    - (Delete) Delete existing comment

- Workout Journal Screen
    - (Read/GET) Query all posts where user is author
    - (Create/POST) Create a new post
    - (Delete) Delete an existing post
 
- [OPTIONAL: List endpoints if using existing API such as Yelp]
