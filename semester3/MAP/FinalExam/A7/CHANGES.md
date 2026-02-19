# Toy Language Interpreter - Implementation Summary

## Problem 1: Repeat...Until Statement

### New Files Created:

#### 1. `/src/model/expression/NotExpression.java`
- **Purpose**: Implements the logical NOT expression (`!exp`)
- **Features**:
  - Evaluates a boolean expression and returns its negation
  - Implements `typeCheck` to verify operand is boolean
  - Used by RepeatUntilStatement to negate the condition

#### 2. `/src/model/statement/RepeatUntilStatement.java`
- **Purpose**: Implements the `repeat stmt1 until exp2` statement
- **Execution Rule**: 
  - Transforms `repeat stmt1 until exp2` into `stmt1; (while(!exp2) stmt1)`
  - Pushes the compound statement onto the execution stack
- **TypeCheck**: 
  - Verifies `exp2` has boolean type
  - TypeChecks `stmt1` in a copy of the type environment

---

## Problem 2: CyclicBarrier Mechanism

### New Files Created:

#### 3. `/src/model/adt/IBarrierTable.java`
- **Purpose**: Interface for the BarrierTable ADT
- **Methods**:
  - `int allocate(int capacity)` - Allocates new barrier entry (synchronized)
  - `Pair<Integer, List<Integer>> get(int address)` - Gets barrier entry
  - `void put(int address, Pair<Integer, List<Integer>> value)` - Updates barrier entry (synchronized)
  - `boolean isDefined(int address)` - Checks if barrier exists
  - `Map<Integer, Pair<Integer, List<Integer>>> getAll()` - Returns all entries

#### 4. `/src/model/state/BarrierTable.java`
- **Purpose**: Implementation of IBarrierTable
- **Features**:
  - Uses `ReentrantLock` for thread-safe atomic operations
  - Maps integer keys to pairs of (capacity, list of waiting thread IDs)
  - Auto-incrementing free location for new barriers

#### 5. `/src/model/statement/NewBarrierStatement.java`
- **Purpose**: Implements `newBarrier(var, exp)` statement
- **Execution Rule**:
  - Evaluates `exp` to get barrier capacity (must be integer)
  - Allocates new barrier entry in BarrierTable with empty waiting list
  - Updates variable with the new barrier index
- **TypeCheck**: Verifies both `var` and `exp` have type `int`

#### 6. `/src/model/statement/AwaitStatement.java`
- **Purpose**: Implements `await(var)` statement
- **Execution Rule**:
  - Looks up barrier index from variable
  - If barrier exists and N1 > NL (capacity > waiting count):
    - If current thread not in waiting list, adds it
    - Pushes await back onto stack (thread waits)
  - If N1 <= NL, barrier is released (thread continues)
- **TypeCheck**: Verifies `var` has type `int`

---

## Modified Files:

### 7. `/src/model/state/ProgramState.java`
- **Changes**:
  - Added `IBarrierTable barrierTable` as a record component
  - Updated constructor to accept BarrierTable parameter
  - Updated `toString()` to display BarrierTable contents

### 8. `/src/model/statement/ForkStatement.java`
- **Changes**:
  - Updated to share parent's BarrierTable with child thread
  - Added `parentBarrierTable` to child ProgramState creation

### 9. `/src/view/gui/InterpreterController.java`
- **Changes**:
  - Added `barrierTable` TableView with three columns (Index, Value, List)
  - Added cell value factories for barrier table columns
  - Updated `refresh()` to clear barrier table when empty
  - Updated `updateDetails()` to populate barrier table

### 10. `/src/view/gui/InterpreterView.fxml`
- **Changes**:
  - Added Barrier Table section with TableView
  - Three columns: `barrierIndexColumn`, `barrierValueColumn`, `barrierListColumn`
  - Adjusted table heights to fit all tables

### 11. `/src/view/gui/ProgramSelectorController.java`
- **Changes**:
  - Added `new BarrierTable()` to ProgramState creation

### 12. `/src/view/gui/MainApp.java`
- **Changes**:
  - Added `ex10` - Repeat Until example program:
    ```
    int v; int x; int y; v=0;
    (repeat (fork(print(v);v=v-1);v=v+1) until v==3);
    x=1;nop;y=3;nop;
    print(v*10)
    ```
    Expected output: {0, 1, 2, 30}
  - Added `ex11` - Barrier example program:
    ```
    Ref int v1; Ref int v2; Ref int v3; int cnt;
    new(v1,2);new(v2,3);new(v3,4);newBarrier(cnt,rH(v2));
    fork( await(cnt);wh(v1,rh(v1)*10);print(rh(v1)) );
    fork( await(cnt);wh(v2,rh(v2)*10);wh(v2,rh(v2)*10);print(rh(v2)) );
    await(cnt);
    print(rH(v3))
    ```
    Expected output: {4, 20, 300}
  - Updated programs list to include ex10 and ex11

### 13. `/src/Interpreter.java`
- **Changes**:
  - Added `ex10` and `ex11` example programs (same as MainApp.java)
  - Updated all ProgramState creations to include `new BarrierTable()`
  - Added menu commands for examples 10 and 11

---

## How to Run:

### GUI Mode:
```bash
cd /Users/m3/Desktop/3/A7
mvn javafx:run
```
Select program 10 for Repeat...Until example or program 11 for Barrier example.

### Text Menu Mode:
```bash
cd /Users/m3/Desktop/3/A7
mvn compile exec:java -Dexec.mainClass="Interpreter"
```
Select option 10 or 11 from the menu.

---

## Expected Outputs:

- **Program 10 (Repeat...Until)**: `{0, 1, 2, 30}`
- **Program 11 (Barrier)**: `{4, 20, 300}`

The step-by-step execution is logged to:
- `log10.txt` for Repeat...Until example
- `log11.txt` for Barrier example
- `log.txt` for GUI mode
