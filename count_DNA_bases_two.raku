# FUnction to open and parse file

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

# Read file
my %FASTA = open_and_parse_fasta("GCF_000010365.1_ASM1036v1_genomic.fna");

#select the sequence we want to look at from the hash
my $carsonella_ruddi = %FASTA{'NC_008512.1 Candidatus Carsonella ruddii PV DNA, complete genome'};


# Split step
# Split string into defined number of chunks

sub split_strings($string, $fragment) {
    my $num_chars = $string.chars;
    if $fragment > $num_chars {die "Fragment cannot be more than string"};
    if $fragment <= 0 {die "Fragment cannot be zero or less than string"};
    my @collections;
    if $num_chars % $fragment == 0 {
        for 1..($num_chars/$fragment) -> $count {
         @collections.append($string.substr($fragment*($count - 1),$fragment))
    }
    } elsif $num_chars % $fragment != 0 {
    for 1..($num_chars div $fragment) -> $count {
        @collections.append($string.substr($fragment*($count - 1),$fragment))
    }
    @collections.append($string.substr($fragment*($num_chars div $fragment)))
}
return @collections
}



# Function to count bases
# input takes string and the chunk number at which to divide the string
sub count_bases(Str $string, Int $fragment) {
    my %counter;
    for split_strings($string, $fragment) -> $element {    
    my %local_hash = $element.comb.Bag.hash;
    for %local_hash.keys -> $var {
        if $var ∈ %counter {
            %counter{$var} = %counter{$var} + %local_hash{$var}
        } else {
            %counter{$var} = %local_hash{$var}
        }            
    }
}
say %counter
}


# Count of each base
count_bases($carsonella_ruddi,20000);
