#include "sll.h"
#include "sllitterator.h"
#include <iostream>
#include "shorttest.h"
#include "extendedtest.h"

using namespace std;

int main() {
	testAll();
	testAllExtended();
    testempty();
	
	cout << "Test over" << endl;
	system("pause");
}
