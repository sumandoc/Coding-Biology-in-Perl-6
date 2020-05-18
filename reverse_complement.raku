# Find reverse complement of a DNA sequence

sub reverse_complement_DNA($dna_sequence) {
    my $reverse_complement = $dna_sequence.subst('A', 't', :g).subst('T', 'a', :g).subst('C', 'g', :g).subst('G', 'c', :g).uc.flip;
    $reverse_complement
}
    
    
put reverse_complement_DNA("ATGCCGTGGTAAAGCCTTAAG")


# Real life scenario

sub open_and_parse_fasta($filepath) {
    my @lines = $filepath.IO.lines;
    my %FASTA_hash; 
    my $FASTA_label = "";
    for @lines {
        my $line = .trim-trailing; 
        if $line.starts-with(">") {
            $FASTA_label = $line.substr(1,);
            %FASTA_hash{$FASTA_label} = ""; 
        } else {
            %FASTA_hash{$FASTA_label} = %FASTA_hash{$FASTA_label} ~ $line;
        }
    }
    return %FASTA_hash   
}



# Function to write reverse complement of DNA 

sub write_reverse_complement($input_file, $output_file, $description) {
  # run our open_and_parse_fasta function and return a FASTA_hash
  my %FASTA = open_and_parse_fasta($input_file);
  # select the description of the sequence we want to look at from the FASTA_hash
  my $carsonella_ruddi = %FASTA{$description};
  # find reverse complement and store in a variable
  my $rev_comp = ($carsonella_ruddi ~~ tr/ATCG/TAGC/).flip;
  # write each line of 80 characters as recommended https://zhanglab.ccmb.med.umich.edu/FASTA/
  my $fh = $output_file.IO.open: :w;
  $fh.print: ">Reverse complement for $description\n";
  $fh.print: $rev_comp.comb(80).join("\n");
  $fh.close
  #spurt $output_file, $rev_comp.comb(80).join("\n")
}

# call write_reverse_complement function with $input_file, $output_file, $description as arguments
write_reverse_complement("GCF_000010365.1_ASM1036v1_genomic.fasta","reverse_complement_GCF_000010365.1_ASM1036v1_genomic.fasta", "NC_008512.1 Candidatus Carsonella ruddii PV DNA, complete genome");

