#include <stdio.h>

// Function to convert a decimal number to binary
void decimalToBinary(int n, char binary[17]) {
    // Handle negative numbers
    if (n < 0) {
        n = 32768 + n;  // Convert to positive equivalent for 16-bit signed integer
    }

    for (int i = 15; i >= 0; i--) {
        binary[i] = (n % 2) + '0';
        n /= 2;
    }
    binary[16] = '\0';  // Null-terminate the string
}

int main() {
    int num;

    // Prompt the user to enter a 16-bit signed number
    printf("Enter a 16-bit signed number: ");
    scanf("%d", &num);

    // Check if the number is within the range of a 16-bit signed integer
    if (num < -32768 || num > 32767) {
        printf("Invalid input. Please enter a 16-bit signed number.\n");
        return 1;
    }

    // Calculate the two's complement
    int complement = -num;

    // Display the original number and its complement in binary
    char binaryNum[17], binaryComplement[17];
    decimalToBinary(num, binaryNum);
    decimalToBinary(complement, binaryComplement);

    printf("Original number: %d (Binary: %s)\n", num, binaryNum);
    printf("Two's complement: %d (Binary: %s)\n", complement, binaryComplement);

    return 0;
}

