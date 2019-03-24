# Tour Review iOS Browser #
Coding challenge, an iPhone app that reads from a public API and displays a list of results

## Summary ##
The task of this challenge was to create an iPhone app that reads from a public API and displays the data. The API returns a list of reviews for guided tours. A review contains a rating, a message and information about the author.

After years of blindly using Alamofire for API calls in iOS, I decided to use this opportunity to look into a different approach. I chose <a href="https://github.com/bustoutsolutions/siesta" target="_blank">Siesta</a> for its lightweight style, caching capabilities and elegant response transformation.

## Compilation ##
This project uses CocoaPods to add third-party repositories to the Xcode project. Before building the project and with CocoaPods installed, run `pod install` in the project's root directory.

## Potential Features & Improvements ##
* Separate detail screen for individual reviews
* Read tour ID from config file
* Add a loading indicator
* Handle API errors
* Unit tests
* Move Info.plist into Config dir
* Clean up characters with encoding glitches

## Third-Party Libraries ##
* <a href="https://github.com/akiroom/AXRatingView" target="_blank">AXRatingView</a>
* <a href="https://github.com/bustoutsolutions/siesta" target="_blank">Siesta</a>
