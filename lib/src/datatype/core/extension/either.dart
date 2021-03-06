import 'package:javelin/src/datatype/datatype_core.dart';
import 'package:javelin/src/typeclass.dart';

//final eitherTypeInstance = EitherType<Object>();

class EitherType<L>
    with
        Invariant<Kind<ForEither, L>>,
        Functor<Kind<ForEither, L>>,
        Bifunctor<ForEither>,
        Apply<Kind<ForEither, L>>,
        Applicative<Kind<ForEither, L>>,
        ApplicativeError<Kind<ForEither, L>, L>,
        Monad<Kind<ForEither, L>>,
        MonadError<Kind<ForEither, L>, L>,
        Foldable<Kind<ForEither, L>>,
        Traverse<Kind<ForEither, L>> {
  ///Applicative
  @override
  Kind<Kind<ForEither, L>, A> pure<A>(A r) => Either.right<L, A>(r);

  ///Bifunctor
  ///
  @override
  Kind<Kind<ForEither, C>, D> bimap<A, B, C, D>(
          Kind<Kind<ForEither, A>, B> fa, C fl(A a), D fr(B b)) =>
      fa.fix().fold((A l) => Either.left<C, D>(fl(l)),
          (B r) => Either.right<C, D>(fr(r)));

  ///ApplicativeError
  @override
  Kind<Kind<ForEither, L>, A> raiseError<A>(L e) => Either.left<L, A>(e);
  @override
  Kind<Kind<ForEither, L>, A> handleErrorWith<A>(
    Kind<Kind<ForEither, L>, A> fa,
    Kind<Kind<ForEither, L>, A> f(L e),
  ) =>
      fa.fix().fold(f, (r) => fa);

  ///Monad
  @override
  Kind<Kind<ForEither, L>, B> flatMap<A, B>(
    Kind<Kind<ForEither, L>, A> fa,
    Kind<Kind<ForEither, L>, B> f(A a),
  ) =>
      fa.fix().fold((l) => Either.left(l), f);

  @override
  B foldLeft<A, B>(
          Kind<Kind<ForEither, L>, A> fa, B initial, B f(B acc, A a)) =>
      fa.fix().fold((l) => initial, (a) => f(initial, a));

  @override
  B foldRight<A, B>(
          Kind<Kind<ForEither, L>, A> fa, B initial, B f(A a, B acc)) =>
      fa.fix().fold((l) => initial, (a) => f(a, initial));

  @override
  Kind<G, Kind<Kind<ForEither, L>, B>> traverse<G, A, B>(
    Kind<Kind<ForEither, L>, A> fa,
    Applicative<G> AG,
    Kind<G, B> f(A a),
  ) =>
      fa.fix().fold((l) => AG.pure(Either.left(l)),
          (r) => AG.map(f(r), (B b) => Either.right(b)));
}

/*
* Show instance for Either datatype
*/
class EitherShow<L, R> implements Show<Either<L, R>> {
  const EitherShow();

  @override
  String show(Either<L, R> fa) => fa.toString();
}

/*
* Eq instance for Either datatype
*/
class EitherEq<L, R> implements Eq<Either<L, R>> {
  const EitherEq();

  @override
  bool eqv(Either<L, R> fa, Either<L, R> fb) => fa == fb;
}
