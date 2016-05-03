# PERL Script to generate tex-units.tex PDFs
# usage: perl make-pdfs.pl

# variables for languages
my @lang_names = ('english', 'ngerman');
my @lang_codes = ('EN',      'DE'    );
if (@lang_names != @lang_codes) {
	 die "ERROR: Mismatch in number of language names and codes!";
}

# variables for color models
my @color_models = ('gray', 'rgb'  );
my @color_codes  = ('gray', 'color');
if (@color_models != @color_codes) {
	 die "ERROR: Mismatch in number of color models and codes!";
}

# other variables
my $job_name = '';
my $lang_name = '';
my $color_model = '';
my $job = '';

# make pdfs
for (my $l = 0; $l < @lang_names; ++$l) {
	$lang_name = $lang_names[$l];
	for (my $c = 0; $c < @color_models; ++$c) {
		$color_model = $color_models[$c];
		$job_name = "tex-units_$color_codes[$c]_$lang_codes[$l]";
		$job = "pdflatex -interaction=nonstopmode -jobname=$job_name \"\\def\\LANGUAGE{$lang_name}\\def\\COLORMODEL{$color_model}\\input{tex-units}\"";
		print "Job: $job\n";
		system($job);
	}
}

# remove aux files etc.
system("rm *.aux");
system("rm *.log");
system("rm *.out");