package controller; // choose package appropriate for your project

import model.values.RefValue;
import model.values.Value;
import model.adt.MyIDictionary;

import java.util.*;
import java.util.stream.Collectors;

public class GarbageCollector {

    /**
        Compute the set of addresses reachable from the symbol table values and
        following references stored in heap values transitively.
    
        @param symTableValues values from the symbol table (Collection<Value>)
        @param heap           the heap map (address -> Value)
        @return set of reachable addresses
    */

    public static Set<Integer> getReachableAddresses(Collection<Value> symTableValues,
                                                     Map<Integer, Value> heap) {
        Set<Integer> reachable = new HashSet<>();
        ArrayDeque<Integer> worklist = new ArrayDeque<>();

        // 1) initialize with addresses referenced directly in symbol table
        for (Value v : symTableValues) {
            if (v instanceof RefValue) {
                int addr = ((RefValue) v).getAddress(); // address 0 is considered invalid / null
                if (addr != 0) {
                    worklist.add(addr);
                }
            }
        }

        // 2) BFS / worklist: follow references stored inside heap entries
        while (!worklist.isEmpty()) {
            Integer addr = worklist.poll();
            if (reachable.contains(addr)) continue; 

            // If the heap actually contains the address, mark reachable and inspect the value
            if (heap.containsKey(addr)) {
                reachable.add(addr);
                Value heapVal = heap.get(addr);

                // If the value stored at that address is itself a RefValue,
                // then its address should be added to worklist (transitive)
                if (heapVal instanceof RefValue) {
                    int nestedAddr = ((RefValue) heapVal).getAddress();
                    if (nestedAddr != 0 && !reachable.contains(nestedAddr)) {
                        worklist.add(nestedAddr);
                    }
                }
            }
            // else: address not present in heap — ignore (will be cleaned)
        }

        return reachable;
    }

    /**
        Keep only the entries in heap whose addresses are in reachable set,
        and update all RefValue addresses to maintain referential integrity.
        Also updates the symbol table with new addresses.
        Returns a new map that can replace heap content.
     */
    public static Map<Integer, Value> safeGarbageCollector(Set<Integer> reachable,
                                                           Map<String, Value> symTable,
                                                           Map<Integer, Value> heap) {
        // First pass: filter reachable entries
        Map<Integer, Value> filtered = heap.entrySet()
                .stream()
                .filter(e -> reachable.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

        // Second pass: create address mapping (old address -> new sequential address)
        Map<Integer, Integer> addressMapping = new HashMap<>();
        int newAddress = 1;
        
        // Build the address mapping with sorted order for deterministic results
        List<Integer> sortedAddresses = new ArrayList<>(filtered.keySet());
        Collections.sort(sortedAddresses);
        
        for (Integer oldAddr : sortedAddresses) {
            addressMapping.put(oldAddr, newAddress);
            newAddress++;
        }

        // Third pass: rebuild heap with updated addresses
        Map<Integer, Value> newHeap = new HashMap<>();
        for (Integer oldAddr : filtered.keySet()) {
            Value val = filtered.get(oldAddr);
            Integer newAddr = addressMapping.get(oldAddr);

            // If the value is a RefValue, update its internal address
            if (val instanceof RefValue) {
                RefValue refVal = (RefValue) val;
                int oldRefAddr = refVal.getAddress();
                // Map old reference address to new address if it exists, otherwise keep original
                int newRefAddr = addressMapping.getOrDefault(oldRefAddr, oldRefAddr);
                val = new RefValue(newRefAddr, refVal.getLocationType());
            }

            newHeap.put(newAddr, val);
        }

        // Fourth pass: update symbol table with new addresses
        for (String varName : symTable.keySet()) {
            Value val = symTable.get(varName);
            if (val instanceof RefValue) {
                RefValue refVal = (RefValue) val;
                int oldAddr = refVal.getAddress();
                int newAddr = addressMapping.getOrDefault(oldAddr, oldAddr);
                if (oldAddr != newAddr) {
                    symTable.put(varName, new RefValue(newAddr, refVal.getLocationType()));
                }
            }
        }

        return newHeap;
    }
}
