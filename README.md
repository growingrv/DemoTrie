# DemoTrie
A sample app using Trie data structure for inserting and searching huge data set from and in a local file. Written in MVVM design pattern

The project covers following asks from the given task:
* Used MVVM design pattern.
* Written in Swift.
* Downloads the list of cities from local JSON file.
* Displays the cities in a scrollable list, in alphabetical order (city first, country after). 
* Ability to filter the results.
* Uses Trie Data structure to insert and search the data.
* The UI is responsive while typing in a filter.
* The list is updated with every character added/removed to/from the filter.
* Each city's cell:
    * Shows the city and country code as title.
    * Shows the coordinates as subtitle.
    * When tapped, navigates the map to the coordinates of the city.
* Created a dynamic UI using SplitViewController that follows the provided wireframes.
* Provided some unit tests for validating search algorithm, VC and VM.
