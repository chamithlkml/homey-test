# TASK - Development Team

1. How would you like to control the visibility of the projects among users.?

- Assume all users can access all projects

2. How would you like to implement the authentication for users.? Do you wish to introduce roles..? Is there any Role based actions limited in the app..?

- No role based access control required. All users can access all projects.
- Just use basic `devise` based username/password authentication.
- No need email confirmation due to time constraints.

3. Do you think `Comments` be applied into other entities. For e.g. Projects designs.?

- No. Let's limit adding comments to project conversations. If not implementing a separate table for comments is preferred.

4. Do you think the statuses of the project are subjected to change in future..?

- Yes. Allow developers to introduce more statuses.

5. Do you wish to delete dependancies when projects, users get deleted?

- No. Since it is about managing a history log let retain the data.


## Setup

- Install Docker desktop

```
git clone git@github.com:chamithlkml/homey-test.git
cd homey-test
mv .sample-env .env
docker compose build
docker compose up
```

This should start the rails server on port 3000 of the host. Access it through http://localhost:3000
Only Sign Up/Sign In is implemented with UI.
All db/model/specs are implemented for the remaining exercise.

## Running RSpecs

Open a new terminal window and run
```
cd homey-test
docker exec -it homey bash
bin/bundle exec rspec
```
