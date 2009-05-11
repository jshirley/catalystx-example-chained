# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Chained';
all_from 'lib/Chained.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';

requires 'Moose';
requires 'MooseX::Types::Path::Class';
requires 'YAML::Syck';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
