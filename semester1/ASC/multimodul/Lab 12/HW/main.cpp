#include <stdio.h>

using namespace std;

extern "C" int hexadecimal(char *str, unsigned int a);
extern "C" int permutations(char *buffer, unsigned int len, char* str);

int main()
{
    unsigned int a;
    char str[9] = {};
    char buffer[64] = {};

    printf("Provide an unsigned number on 32 bits: ");
    scanf("%u", &a);

    int hex_digits = hexadecimal(str, a);

    printf("The hexadecimal representation of %u and its circular permutations are: \n", a);
    printf("%s\n", str);

    int nop = permutations(buffer, hex_digits, str);

    int i = 0;
    while (i < nop * 9) {
        printf("%s\n", buffer + i);
        i += 9;
    }

    return 0;
}