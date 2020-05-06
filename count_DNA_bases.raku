# DNA on computers

## Counting DNA length


# Raku handles all strings as UTF-8 by default

sub print_sequence_length(){
  my $seq = "AGTGTCCCTG"; #store DNA strand as a string in the variable seq
  put chars($seq)
}

print_sequence_length();



#******************************************************
#                   NEXT
#******************************************************

# function takes in a filepath then opens & parses the
# fasta file returning a hash

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



# function to count base occurence and print results
# whenever you want to count things in a collection, the rule of thumb is to use the Bag structure

sub count_bases() {
  #run our open FASTA function and set returned FASTA_dict to FASTA variable
  my %FASTA = open_and_parse_fasta("GCF_000010365.1_ASM1036v1_genomic.fna");
  #select the sequence we want to look at from the hash
  my $carsonella_ruddi = %FASTA{'NC_008512.1 Candidatus Carsonella ruddii PV DNA, complete genome'};
  #counts and prints the bases in the genome
  $carsonella_ruddi.comb.Bag.hash
}

# Call the function 

say count_bases()
# Output will be 
# {A => 66734, C => 13501, G => 12946, T => 66481}

put count_bases()

# Output will be

# A   66734
# C   13501
# G   12946
# T   66481
