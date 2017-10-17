unit module App::Core;

#e
class X::App::Runtime is X::AdHoc is export {}
#e
class X::App::IO is X::App::Runtime is export {}

class X::App::Abort is X::AdHoc {
    multi method gist(X::App::Abort:D:) { $.payload }
}

#e
sub abort(Str:D $message) is export {
    die X::App::Abort.new(payload => $message);
}
