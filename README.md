# GUMBALL EVENTS
## Joshua Crinall & Thomas Crowley
<br />
<br />
Events API Documentation:  http://api.eventful.com/docs<br />
OpenWeatherMap API Documentation:  https://openweathermap.org/current
<br />
eventful username: sc14talcbf8ef
<br />
Welcome to Gumball Events! <br />
Gumball events is an iOS app specialising in the ability to quickly pull local
event information from the Eventful web service. The app takes user query data
and returns a selection of events in the form of gumballs!
<br />

### Usage
Run Gumball Events from XCode, using the iOS device emulator, or your own iOS
device. You will be presented with a simple screen consisting of an SKScene,
with a small icon showing the current weather in your area, and a "Filters" 
button. Tapping this button will allow you to enter query data, such as city
name, event category and keywords. These will be saved as user defaults for data
persistence. Once you have returned to the previous screen, tapping the gumball
icon will spawn a number of gumballs each tied to a specific event from the 
Eventful API, which can be manipulated with touch input, or tapped to view more 
details about the event, as well as a map for directions.

### Notes on testing
Due to the nature of our project, in which almost all data is fed through an
SKScene, unit testing was not a viable option for verification of our 
application's functionality. This is because we had to regularly pass data 
through NotificationCenter objects to & from an SKScene, which view controllers 
do not have direct access to. As such, our tests had to be manual, which will be 
reflected in our project report.