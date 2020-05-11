# DNA on computers

## Counting DNA length


# Raku handles all strings as UTF-8 by default

# Given a string, this function prints the length of the string.

sub print_sequence_length(Str $seq){
  return chars($seq)
}

put print_sequence_length("ATTTCCGCG");



#******************************************************
#                   NEXT
#******************************************************

# Function to open and parse file

sub open_and_parse_fasta($filepath) {
    my @lines = $filepath.IO.lines;
    my %FASTA_hash; 
    my $FASTA_label = "";
    for @lines {
        my $line = $_.trim-trailing; 
        if $line.starts-with(">") {
            $FASTA_label = $line.substr(1,);
            %FASTA_hash{$FASTA_label} = ""; 
        } else {
            %FASTA_hash{$FASTA_label} = %FASTA_hash{$FASTA_label} ~ $line;
        }
    }
    return %FASTA_hash   
}


# Function to count base (nucleotides) occurence and print results
# Whenever you want to count things in a collection, the rule of thumb is to use the Bag structure

sub count_bases($file, $description) {
  # run our open_and_parse_fasta function and return a FASTA_hash
  my %FASTA = open_and_parse_fasta($file);
  # select the description of the sequence we want to look at from the FASTA_hash
  my $carsonella_ruddi = %FASTA{$description};
  # counts and prints the bases in the genome
  $carsonella_ruddi.comb.Bag.hash
}

# Call the function 
say count_bases("GCF_000010365.1_ASM1036v1_genomic.fasta", "NC_008512.1 Candidatus Carsonella ruddii PV DNA, complete genome");

# Output will be 
# {A => 66734, C => 13501, G => 12946, T => 66481}

put count_bases("GCF_000010365.1_ASM1036v1_genomic.fasta", "NC_008512.1 Candidatus Carsonella ruddii PV DNA, complete genome");

# Output will be

# A   66734
# C   13501
# G   12946
# T   66481


# Time taken for running the script

END say now - INIT now;
