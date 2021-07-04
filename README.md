# AirProximity
iOS App to see mock live city Air Quality Index data/graph in Swift with WebSocket

**Note**
- Reduce socket timer value in constants file to see frequent changes on graph quickly

**Features**
- Singleton Wrapper to manage websocket connections
- VFL & programatic UI
- Use of Delegation and Protocols
- ViewModels to improve testability
- Added one test case to check connections

**Architecture**:

![AQI](https://user-images.githubusercontent.com/13964462/124398266-6ce54480-dd32-11eb-998c-11bf3a7e1469.png)


**Future Scope**
- Graph: Add params and specific entities to track
- Add Core Data or persistent storage of AQI data
- Add more test cases for data reception and validation
- Error Handling
- Localization
- Fix TODOs

**Screenshots**

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-07-05 at 01 04 49](https://user-images.githubusercontent.com/13964462/124398534-d4e85a80-dd33-11eb-919c-65a88c36dc15.png)
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-07-05 at 01 05 46](https://user-images.githubusercontent.com/13964462/124398539-da45a500-dd33-11eb-8c14-060dd259d803.png)


**Total Time Taken**
6 Hrs:

Planning: 1

Websockets: 1.5

Dependancy (Charts) : 0.5

UI: 1.5

Parsing: 0.5

TestCase and Unit Testing: 1




