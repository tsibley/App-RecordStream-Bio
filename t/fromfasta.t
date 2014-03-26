use strict;
use warnings;
use Test::More 'no_plan';

use App::RecordStream::Test::Tester;

BEGIN { use_ok( 'App::RecordStream::Operation::fromfasta' ) };

my $input;
my $output;

my $tester = App::RecordStream::Test::Tester->new('fromfasta');

$input = <<'INPUT';
>foo baz bar
TCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGG
GGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACT
TCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGG
GGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACT
> baz
SLYNTVAVLYYVHQR
>empty
>bogus
TCATTATATAATACAGTAGC>>CCCTCTATTGTGTGCATCAAAGG
INPUT
$output = <<'OUTPUT';
{"id":"foo baz bar","sequence":"TCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGG\nGGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACT\nTCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGG\nGGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACT"}
{"id":" baz","sequence":"SLYNTVAVLYYVHQR"}
{"id":"empty","sequence":null}
{"id":"bogus","sequence":"TCATTATATAATACAGTAGC>>CCCTCTATTGTGTGCATCAAAGG"}
OUTPUT
$tester->test_input([], $input, $output);

$output = <<'OUTPUT';
{"id":"foo baz bar","sequence":"TCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGGGGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACTTCATTATATAATACAGTAGCAACCCTCTATTGTGTGCATCAAAGGGGAAACTACGTGTGTTATCTCCCAACGATGACATAATATATTACT"}
{"id":" baz","sequence":"SLYNTVAVLYYVHQR"}
{"id":"empty","sequence":null}
{"id":"bogus","sequence":"TCATTATATAATACAGTAGC>>CCCTCTATTGTGTGCATCAAAGG"}
OUTPUT
$tester->test_input(['--oneline'], $input, $output);