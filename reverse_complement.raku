# Find reverse complement of a DNA sequence

sub reverse_complement_DNA($dna_sequence) {
    my $reverse_complement = $dna_sequence.subst('A', 't', :g).subst('T', 'a', :g).subst('C', 'g', :g).subst('G', 'c', :g).uc.flip;
    $reverse_complement
}
    
    
put reverse_complement_DNA("ATGCCGTGGTAAAGCCTTAAG")
