// inline_example.c

#include <stdio.h>

// Static inline function to add two numbers
static inline int addNumbers(int a, int b) {
    return a + b;
}

// Static inline function to subtract two numbers
static inline int subtractNumbers(int a, int b) {
    return a - b;
}

int main() {
    int resultAdd, resultSubtract;

    // Call the inline functions
    resultAdd = addNumbers(9, 11);
    resultSubtract = subtractNumbers(14, 5);

    // Display the results
    printf("Result of addition: %d\n", resultAdd);
    printf("Result of subtraction: %d\n", resultSubtract);

    return 0;
}

