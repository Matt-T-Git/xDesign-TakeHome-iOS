# xDesign-TakeHome-iOS

## Reported Issues Fixed:

- App crashes on launch - tableView.reloadData() called on wrong thread
- Book data does not display - resolved 
- Overlapping text in the cells - resolved

## Improvements
- Non reported UI issues
- Fix storyboard warnings
- Refactor network calls to use Network Class
- Improved error handling
- Refactor app to use MVVM pattern

## Additional Features
- Added search functionality for each (Books, Houses, Characters)

## Given More Time / Still Todo
- Characters API has no real valid data and is only returning one name
- Further Improve error handling (display message to user?)
- Potentially break each ViewController into it's own storyboard to avoid merge conflicts with multiple devlopers
- Fix warning for depreciated init() for MockURL

### Time spent ~ 6-7 hours in patches across 2 days
