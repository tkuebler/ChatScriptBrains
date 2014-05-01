#!perl 
#
# first pass at a aiml2cs converter - contributions welcome

use Cwd;
use XML::Simple;
use Data::Dumper;
use File::Basename;
use File::Find;

my $startDir = getcwd(); 
my $filename = $ARGV[0];
my $outDir = "cs";

if ( -d $filename )
{
	print "Processing files in $filename...\n";
	finddepth(\&convertFile, $filename);
} 
elsif ( -f $filename )
{
	$_ = $filename;
	&convertFile($filename);
}

sub convertFile 
{
my $_filename = $_;

my ( $name, $path, $suffix ) = fileparse($_filename);
my ($topic, $extension, @junk) = split(/\./,$name);
print "processing $_...\n";

my $aiml = XMLin($_filename);

print Dumper($aiml);

my $out = "TOPIC: ~$topic-aiml ()\n\n";

foreach my $category (@{$aiml->{category}})
{
# 	http://www.chatbots.org/ai_zone/viewthread/1466/
# 	
# 	1. convert all upper case to lower case—this will be flawed for words which are actually proper names
# 	2. convert the AIML pattern of   word * word * word to u: (< word * word >)
# 	3. convert the AIML pattern of * word * word * word to u: ( word * word * word >)
# 	and so on, for all the sentence boundary forms.
# 	4. for aiml output that is just words, put them on the chatscript output side.
# 	5. to map other functions of aiml output, you have to handle that on a function decode by function decode basis.

	my $pattern = lc $category->{pattern};
	my $test = $pattern;
	$test =~ s/\*/TEST/g;
	$pattern =~ s/(.*)\*(.*)\*(.*)/<$1*$2*$3>/g; 		# 2
	$pattern =~ s/(.*)\*(.*)\*(.*)\*/<$1*$2*$3*/g;		# 3
	$pattern =~ s/\*(.*)\*(.*)\*(.*)/*$1*$2*$3*>/g;		# 3
	$pattern =~ s/(.*)\*(.*)/<$1*$2>/g; 		# 2
	$pattern =~ s/(.*)\*(.*)\*/<$1*$2*/g;		# 3
	$pattern =~ s/\*(.*)\*(.*)/*$1*$2>/g;		# 3
	$pattern =~ s/ +/ /g;

	if ( $category->{template}->{bot} ) 
	{
		$out .= "#! $test\n";
		$out .= "u: \($pattern\) $category->{template}->{bot}->{name}\n";
	}
	elsif ( $category->{template}->{srai} ) 
	{
		$out .= "#! $test\n";
		if ( $category->{template}->{srai}->{content} ) 
		{
			$out .= "u: ($pattern) \^reuse($category->{template}->{srai}->{content})\n";
		}
		else
		{
			$out .= "u: ($pattern) \^reuse($category->{template}->{srai})\n";
		}
	}
	elsif ( $category->{template}->{random} )
	{
		$out .= "#! $test\n";
		$out .= "u: ($pattern) ";
		foreach my $li ( @{$category->{template}->{random}->{li}})
		{
			if ( ref($li) eq "STRING")
			{
				$out .= "[$li]\n";	
			} 
			else
			{
				$out .= "# $li \n";
			}
		}
		$out .= "\n"
	}
	elsif ( $category->{template}->{content} )
	{
		$ref = ref($category->{template}->{content});
		if ( $ref ne "STRING" )
		{
			$out .= "#! $test\n";
			$out .= "u: \($pattern\) $category->{template}->{content}[0]\n";
		}
		else
		{
			$out .= "#! $test\n";
			$out .= "u: \($pattern\) $category->{template}->{content}\n";
		}
	} else {
		$out .= "#! $test\n";
		$out .= "u: \($pattern\) $category->{template}\n";
	}
}

my $of =  "$startDir/$outDir\/$topic\.top";
print  " writing to: $of from " . getcwd() . "\n";
open (my $fh, '>', "$of") or die "Can't open $of for writing - $!\n";
print $fh $out;
}

print $out;
