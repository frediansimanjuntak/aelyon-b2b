# AELYON - B2B

Aelyon project is one platform B2B

## System Dependencies

The following are needed by this project:

* [PostgreSQL](http://www.postgresql.org/)
* [Ruby On Rails](https://guides.rubyonrails.org/v6.0/getting_started.html)

## Getting Started

Clone this repository and bundle.

    git clone https://github.com/frediansimanjuntak/aelyon-b2b.git
    cd aelyon-b2b
    bundle install

Create and initialize the database using this command:

    rails db:setup

Load the sample data

    rails spree_sample:load

Start the application server.

    rails server

Access the application at [http://localhost:3000/](http://localhost:3000/) and login using the email and password that was entered earlier on.

## Branching

* `master` is the active development branch

Make a new branch to work on your development:

    git checkout -b <name_of_branch>

You can check the location of your branch using `git branch` command.

All local development should be done in the appropriately named branches:

* `feature/<branch_name>` for substantial new features or functions
* `enhance/<branch_name>` for minor feature or function enhancement
* `refactor/<branch_name>` for code refactoring of existing functions
* `bugfix/<branch_name>` for bug fixes

**WARNING: Do not merge your changes directly into your local master
branch and push to GitHub!!!**

If you are done developing the component you are working on, push your branch to github
and open a [pull request](https://help.github.com/articles/creating-a-pull-request/) to the `master` branch.

Give your pull request a title and describe what you are trying to
achieve with your code. The branch or release manager will review your
code and take the next appropriate actions.

## Others

This project following spreecommerce as a base system. Here the GitHub Link
* [SpreeCommerce](https://github.com/spree/spree)

Update Spree 4 in Rails 6
* [Update Spree 4 in Rails 6](https://guides.spreecommerce.org/developer/upgrades/three-dot-seven-to-four-dot-oh.html)
