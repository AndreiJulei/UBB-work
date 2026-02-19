#include <assert.h>
#include "SortedMap.h"
#include "SMIterator.h"
#include "ShortTest.h"
#include <exception>
using namespace std;

bool relation(TKey key1, TKey key2) {
    return key1 <= key2;
}

void testAll() {
    SortedMap sm(relation);
    assert(sm.size() == 0);
    assert(sm.isEmpty());

    sm.add(1, 2);
    assert(sm.size() == 1);
    assert(!sm.isEmpty());
    assert(sm.search(1) != NULL_TVALUE);

    TValue v = sm.add(1, 3);
    assert(v == 2);
    assert(sm.search(1) == 3);

    SMIterator it = sm.iterator();
    it.first();
    while (it.valid()) {
        TElem e = it.getCurrent();
        assert(e.second != NULL_TVALUE);
        it.next();
    }

    assert(sm.remove(1) == 3);
    assert(sm.isEmpty());
}