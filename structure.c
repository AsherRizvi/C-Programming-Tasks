#include <stdio.h>

// Define the structure for a student
struct Student {
    char name[50];
    int id;
    int age;
};

int main() {
    // Declare a variable of type struct Student
    struct Student student;

    // Input information from the user
    printf("Enter student name: ");
    scanf("%s", student.name);

    printf("Enter student ID: ");
    scanf("%d", &student.id);

    printf("Enter student age: ");
    scanf("%d", &student.age);

    // Display the entered information
    printf("\nStudent Information:\n");
    printf("Name: %s\n", student.name);
    printf("ID: %d\n", student.id);
    printf("Age: %d\n", student.age);

    return 0;
}

