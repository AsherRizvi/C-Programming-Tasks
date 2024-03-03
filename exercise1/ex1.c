#include <string.h>
#include "exercise1/ex1.h"

void compute_nucleotide_occurrences(DNA_sequence *dna_seq) {
    dna_seq->A_count = 0;
    dna_seq->C_count = 0;
    dna_seq->G_count = 0;
    dna_seq->T_count = 0;

    for (int i = 0; dna_seq->sequence[i] != '\0' && i < 20; i++) {
        switch (dna_seq->sequence[i]) {
            case 'A':
                dna_seq->A_count++;
                break;
            case 'C':
                dna_seq->C_count++;
                break;
            case 'G':
                dna_seq->G_count++;
                break;
            case 'T':
                dna_seq->T_count++;
                break;
        }
    }
}

