# How to Start
* Clone this repository.
* Navigate to the project directory.
* Run `docker-compose build && docker-compose down --remove-orphans && docker-compose up -d`.

# Where to Find the Issue
After launching the Docker containers, the Laravel application will start, and a test queued job will be executed in the schedule.

All logs are located in the standard Laravel logs folder: 
* `{path_to_project}/laravel/storage/logs/laravel.log` (for Laravel logs).
* `{path_to_project}/laravel/storage/logs/cron.log` (for Cron logs).

A portion of these logs is also available in the repository for easy access without the need to run the application.
