# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Used Sinatra
- [x] Use ActiveRecord for storing information in a database - Used ActiveRecord to create users,games, and users_games tables
- [x] Include more than one model class (e.g. User, Post, Category) - Have a Game, User, and UsersGame model
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - Users have many games and games have many users both through users_games
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - users_games belongs to both users and games
- [x] Include user accounts with unique login attribute (username or email) - Does this
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Users can add to their game list, edit their entries, view their entries, and delete their entries
- [x] Ensure that users can't modify content created by other users - users can only modify their own entries
- [x] Include user input validations - makes sure inputs are as wanted and if they're not gives an error and makes them retry
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - gives error messages and validation on sign up
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - did this

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message