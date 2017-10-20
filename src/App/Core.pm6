unit module App::Core;

class X::Runtime is X::AdHoc is export {}

class X::IO is X::Runtime is export {}

class X::Abort is X::AdHoc {
    multi method gist(X::Abort:D:) { $.payload }
}

sub abort(Str:D $message) is export {
    die X::Abort.new(payload => $message);
}
