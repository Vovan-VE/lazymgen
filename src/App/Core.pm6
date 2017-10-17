unit module App::Core;

class X::App::Runtime is X::AdHoc is export {}

class X::App::IO is X::App::Runtime is export {}

class X::App::Abort is X::AdHoc {
    multi method gist(X::App::Abort:D:) { $.payload }
}

sub abort(Str:D $message) is export {
    die X::App::Abort.new(payload => $message);
}
