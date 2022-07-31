# Project-6-Five-Guys
To Run:
  1. bundle install
  2. yarn add webpacks
  3. rails assets:clobber
  4. rails assets:precompile
  5. yarn config set ignore-engines true
  6. git config --global core.autocrlf true
  7. rails s

Positions:

Noah: Project manager / meeting manager

- Tasks:
    - Created stocks, ownedstocks, transactions, and users models.
    - Impemented buying and selling controller and front end functionality
    - implemented transactions functionality, and view
    - implemented graph functionality on stock pages
    - created navbar
    - Created routes from trading 
    - Added error checking validations to user and ownedstocks
    - added user liquidcash in signup field

Jake: Implementation Manager

- Tasks:
    - Initialized Stock API
    - Created websocket to update stock prices
    - Implemented live price updates to database
    - Implemented full page polling and partially polling to update live stock prices on view
    - Created partial views for stocks
    - Cerated routes for live price update functionality

Daniel: Documentation Manager

- Tasks: Initialized Devise, added custom fields to devise

Hao: Testing manager

- Tasks: 
