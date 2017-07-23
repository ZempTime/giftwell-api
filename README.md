# Team Gifts

## Rails Namespacing Strategy

> The first category, physical, corresponds to the models, controllers, and helpers and views normally associated with a Rails application. These are the models that descend from ActiveRecord::Base, and correspond directly to physical database tables.
>
> The next category, the pair of logical and service, comes into play when your application is large or complex enough that it is ready to evolve to an SOA. At this point you will define an API for clients that should remain relatively fixed. To prevent your service API from changing every time you tweak your database design, an abstraction layer that’s not tied directly to database tables is necessary. Under the models directory, add a directory logical, where the logical or domain model classes will go. Under controllers, create a directory called service, which we’ll use later in this book when we break our application into a service-oriented architecture. Although you won’t have anything to put in these directories right now, but create them anyway. The mere presence of this hierarchy will remind you that something does go here, and that it’s of a different sort than what we put in the physical directories.
>
> The third category is for utility scripts intended to be run with script/runner. These are background processes that send out emails or do various other tasks. Usually they run on a schedule or are run by hand. These classes don’t have helpers, and the controller is cron or you, the operator.
>
> You may find that your application has additional categories. You will also no doubt find the need, within each category, to further subdivide in order to maintain your own sanity. The main point to understand is that if you don’t lay out a framework for managing different types of classes from the start, you will end up with a mess that is hard to tame late in the game.

- [Dan Chak](https://dan.chak.org/enterprise-rails/chapter-3-organizing-with-modules/)
