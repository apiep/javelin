import 'package:javelin/javelin_typeclass.dart';
import 'package:javelin/src/datatype/option.dart';

class OptionType
    with OptionShow, OptionEq, OptionApplicative, OptionFunctor, OptionMonad {
  const OptionType();
}

/*
* Function instance for Option datatype
*/
mixin OptionFunctor on Applicative<ForOption> implements Functor<ForOption> {
  @override
  Kind<ForOption, B> map<A, B>(
    Kind<ForOption, A> fa,
    B f(A a),
  ) =>
      fa.fix().fold(
            () => Option.none(),
            (value) => pure(f(value)),
          );
}

/*
* Applicative instance for Option datatype
*/
mixin OptionApplicative implements Applicative<ForOption> {
  @override
  Kind<ForOption, A> pure<A>(A a) => Option.of(a);
}

/*
* Monad instance for Option datatype
*/
mixin OptionMonad implements Monad<ForOption> {
  @override
  Kind<ForOption, B> flatMap<A, B>(
    Kind<ForOption, A> fa,
    Kind<ForOption, B> f(A a),
  ) =>
      fa.fix().fold(() => Option.none(), f);
}

/*
* Show instance for Option datatype
*/
mixin OptionShow implements Show<ForOption> {
  @override
  String show<A>(Kind<ForOption, A> fa) =>
      fa.fix().fold(() => 'None()', (value) => 'Some($value)');
}

/*
* Eq instance for Option datatype
*/
mixin OptionEq implements Eq<ForOption> {
  @override
  bool eqv<A>(Kind<ForOption, A> a, Kind<ForOption, A> b) => a.fix().fold(
      () => b.fix().fold(
            () => true,
            (_) => false,
          ),
      (value) => b.fix().fold(
            () => false,
            (value) => value == value,
          ));
}
