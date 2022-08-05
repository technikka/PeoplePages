# People Pages

This is my final project for the Rails course over at [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project). The goal was to implement the core user functionality of Facebook: users, profiles, posts, news feed, "friending" and "liking". A project this feature-heavy could have consumed me for months but I was only able to allow four weeks, and a fifth week spent debugging. This is what I was able to complete in that time, which was plenty to achieve my main goals. 

Check it out live: [People Pages](https://people-pages.herokuapp.com) 
<br/>
^^ Note: at this time all profile images are stored locally for about a day, then lost. When I have more time I can continue troubleshooting the AWS S3 storage credentials issues that were preventing me from storing images.


## What this project is lacking, or, Notes on curious behavior

* Error handeling-- because all my objects with validations are interacted with inside of a Turbo Frame or Stream, this complicated getting error messages to the user due to no redirect occurring. My understanding is that at this stage Turbo cannot handle 422 response errors and I ran out of time to implement an alternate solution. This causes undesirable behavior in a couple of cases, such as in submitting an empty post or comment.  

* Confirmation to delete resources (posts, comments)-- Turbo handles confirmations ("Are you sure?") and Turbo and I kept butting heads throughout this project. Despite giving fair time to this issue, adding a turbo_confirm to a link consistently broke the link so that no request is sent. I think requiring a confirmation to destroy a user resource is good practice, but I was unable to implement it here.

* Validations on model objects-- This project has considerably few validations in place, exposing itself to problems if it were to be fiddled with. This was an area of struggle and I found the documentation on this to be lacking-- leading me to wonder if poor design on my part is the issue. For example, I haven't yet figured out how to successfully validate that a foreign key of some type exists (i.e -> validates :this_id || :this_id || :this_id).  

* Testing-- Something I suspect I could have greatly benefited from but have not learned yet.



## Newly acquired tools and technologies for this project

* Turbo, a component of the Hotwire technologies-- I put a lot of time into experimenting and understanding Frames and Streams, made difficult by the lack of documentation at this time for using these new tools. I am happy to see the fruit of this labor: posts and comments append or update beautifully within a stream and, all "friending" and "liking" functionality operates within a frame for efficient user management of these resources. I am not at all sure how scalable my approaches to these tools are, but i'm decently comfortable using them now.

* Active Storage-- I opted to learn how to use active storage to attach a profile image rather than Odin's recomendation of using a gravatar gem. Choosing Gravatar as the singuluar option for a profile image is limiting, exclusive, and simple to implement if ever I have the need. I chose to gain experience with this core module of Rails. I used the active_storage_validations gem to validate content type.

* Optimization and Bullet--  My first couple optimization sessions I made a good deal of difference by using my server logs to help me determine where to use eager loading. After that I began struggling to eliminate certain N + 1 query problems I was seeing. I decided to try Bullet, a gem designed to help identify where eager loading an association is advised to avoid the N + 1 query problem. It also showed me some areas where i was eager loading unnecessarily. It's not a perfect tool, in some cases it would advise me to eager load then immediately advise me to remove the code it just suggested I add. But it was the quick solution I needed and did make a difference.

* Tailwind CSS-- I had recently become curious about this CSS framework, seeing it as a potentially handy tool for quick styling anywhere styling isn't involved in the main goals of the project. I decided this project was a great opportunity to give it a go. I found it incredibly easy to get going with and nice to use. I'd decide what css I'd like to apply to a given element and then look up Tailwind's keywords for it, which are intuitive enough that quickly I was pulling these keywords from memory. I did relish not having to switch between files while styling.



### This project can serve as a future example for

* Using PostgreSQL for my database from the beginning, as opposed to the default SQLite3.
* Configuring Devise to play nicely with Turbo. (See local: Notes/configuring_devise)



### Additional Reflections

This being the largest Rails project I've built so far, I learned such a tremendous amount each week that I consistently wished I could go back and refactor my code from the week before, or even days before. In one or two cases I did entirely redesign the way I approached a problem as to not build off of such poor design; but most often I had to leave some redundancies, bulky logic-heavy controllers and maybe too much logic in my views as well. This will be a very fun redesign project some day.  

I feel questionable about how I handle the creation/deletion of notifications. I opted for using callback methods in the models of resources which are associated with notifications, but I can't determine if this is an appropriate use of callbacks. The outcome has exposed some redundancies, but I'm not sure if this is an issue with my implementation, or just poor design altogether.

A final note on Turbo. This is my first time experiencing the frustrations of using a new technology that doesn't have thorough documentation. I can see why Rails was quick to add Turbo as the default but it being the default adds complications for Rails newbies. I don't think I could overstate how much time I spent working out issues concering Turbo for this project, all the while having a feeling of wandering alone and dehydrated in a barren desert... Haha! I got through it though, leveled up my investigative skills, and with a newfound appreciation for well-documented technologies and teamwork.



### Next Version

If I'm able to continue work on this project, the next version would ideally include:

* Functionality for commenting on comments
* More advanced posts-- allowing images, links, etc.
* Private messages between users
* Alerts for notifications
* More notifications, like when a friend request has been accepted.
* Additional features for profiles including being able to add more than one website or social link.
* The profile image will be "likable" and "comentable".
* OmniAuth for sign in with Facebook
* Mailers for welcome email and forgot password.
* Viewing "likes" and notifications will be pop out elements rather than seperate pages.
