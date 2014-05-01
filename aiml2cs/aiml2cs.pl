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

my $out = "TOPIC: ~$topic-aiml ()\n\n";

foreach my $category (@{$aiml->{category}})
{
	my $pattern = $test = lc $category->{pattern};
	$test =~ s/\*//g;
	$test =~ s/ +/ /g;
	if ( $category->{template}->{srai} ) 
	{
		$out .= "#! $test\n";
		$out .=  "u: ($pattern) \^reuse($category->{template}->{srai})\n";
	}
	elsif ( $category->{template}->{content} )
	{
		$ref = ref($category->{template}->{content});
		if ( $ref eq "ARRAY")
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
