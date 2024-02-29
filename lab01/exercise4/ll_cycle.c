#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    if (head == NULL) {
        // Empty list, no cycle
        return 0;
    }

    // Initialize two pointers, slow and fast
    node *slow_ptr = head;
    node *fast_ptr = head;

    while (fast_ptr != NULL && fast_ptr->next != NULL) {
        // Advance fast_ptr by two nodes
        fast_ptr = fast_ptr->next->next;

        // Advance slow_ptr by one node
        slow_ptr = slow_ptr->next;

        // If fast_ptr and slow_ptr point to the same node, there is a cycle
        if (fast_ptr == slow_ptr) {
            return 1;  // Cycle detected
        }
    }

    // If the loop terminates, there is no cycle
    return 0;
}

