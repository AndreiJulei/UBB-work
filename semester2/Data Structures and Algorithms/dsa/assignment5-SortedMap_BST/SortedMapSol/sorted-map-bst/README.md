# Sorted Map Implementation using Binary Search Tree

## Overview
This project implements the Abstract Data Type (ADT) Sorted Map using a Binary Search Tree (BST) with linked representation on an array. The Sorted Map allows for efficient storage and retrieval of key-value pairs, supporting operations such as adding, searching, and removing elements.

## Project Structure
The project is organized as follows:

```
sorted-map-bst
├── src
│   ├── headers
│   │   ├── SortedMap.h        // Header file for the SortedMap class
│   │   ├── SMIterator.h       // Header file for the SMIterator class
│   │   ├── ShortTest.h        // Header file for basic tests
│   │   └── ExtendedTest.h     // Header file for extended tests
│   ├── implementations
│   │   ├── SortedMap.cpp      // Implementation of the SortedMap class
│   │   ├── SMIterator.cpp     // Implementation of the SMIterator class
│   │   ├── ShortTest.cpp      // Implementation of basic tests
│   │   └── ExtendedTest.cpp   // Implementation of extended tests
│   └── App.cpp                // Entry point of the application
├── CMakeLists.txt             // CMake configuration file
└── README.md                  // Project documentation
```

## Building the Project
To build the project, you need to have CMake installed. Follow these steps:

1. Navigate to the project directory:
   ```
   cd sorted-map-bst
   ```

2. Create a build directory and navigate into it:
   ```
   mkdir build
   cd build
   ```

3. Run CMake to configure the project:
   ```
   cmake ..
   ```

4. Build the project:
   ```
   make
   ```

## Running Tests
After building the project, you can run the tests by executing the generated executable:
```
./App
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.