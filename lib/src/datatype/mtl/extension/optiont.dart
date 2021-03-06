import 'package:javelin/javelin.dart';
import 'package:javelin/src/datatype/datatype_mtl.dart';

class OptionTFunctor<F>
    with Invariant<Kind<ForOptionT, F>>, Functor<Kind<ForOptionT, F>> {
  final Functor<F> FF;

  OptionTFunctor(this.FF);

  @override
  Kind<Kind<ForOptionT, F>, B> map<A, B>(
          Kind<Kind<ForOptionT, F>, A> fa, B f(A a)) =>
      fa.fix().map(FF, f);
}

class OptionTMonadError<F>
    with
        Invariant<Kind<ForOptionT, F>>,
        Functor<Kind<ForOptionT, F>>,
        Apply<Kind<ForOptionT, F>>,
        Applicative<Kind<ForOptionT, F>>,
        Monad<Kind<ForOptionT, F>>,
        ApplicativeError<Kind<ForOptionT, F>, Unit>,
        MonadError<Kind<ForOptionT, F>, Unit> {
  final Monad<F> MF;

  OptionTMonadError(this.MF);

  @override
  Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(MF.pure(Option.of(a)));

  @override
  Kind<Kind<ForOptionT, F>, B> flatMap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
          Kind<Kind<ForOptionT, F>, B> f(A a)) =>
      fa.fix().flatMap(MF, f);

  @override
  Kind<Kind<ForOptionT, F>, A> raiseError<A>(Unit e) => OptionT.none(MF);

  @override
  Kind<Kind<ForOptionT, F>, A> handleErrorWith<A>(
          Kind<Kind<ForOptionT, F>, A> fa,
          Kind<Kind<ForOptionT, F>, A> f(Unit e)) =>
      OptionT(
        MF.flatMap(
            fa.fix().value,
            (Option<A> option) => option.fold(
                  () => f(Unit()).fix().value,
                  (a) => MF.pure(Option.of(a)),
                )),
      );
}

class OptionTMonadErrorF<F, E>
    with
        Invariant<Kind<ForOptionT, F>>,
        Functor<Kind<ForOptionT, F>>,
        Apply<Kind<ForOptionT, F>>,
        Applicative<Kind<ForOptionT, F>>,
        Monad<Kind<ForOptionT, F>>,
        ApplicativeError<Kind<ForOptionT, F>, E>,
        MonadError<Kind<ForOptionT, F>, E> {
  final MonadError<F, E> ME;

  OptionTMonadErrorF(this.ME);

  @override
  Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(ME.pure(Option.of(a)));

  @override
  Kind<Kind<ForOptionT, F>, B> flatMap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
          Kind<Kind<ForOptionT, F>, B> f(A a)) =>
      fa.fix().flatMap(ME, f);

  @override
  Kind<Kind<ForOptionT, F>, A> raiseError<A>(E e) => OptionT(ME.raiseError(e));

  @override
  Kind<Kind<ForOptionT, F>, A> handleErrorWith<A>(
          Kind<Kind<ForOptionT, F>, A> fa,
          Kind<Kind<ForOptionT, F>, A> f(E e)) =>
      OptionT(ME.handleErrorWith(fa.fix().value, (e) => f(e).fix().value));
}

class OptionTShow<F, A> implements Show<OptionT<F, A>> {
  const OptionTShow();

  @override
  String show(OptionT<F, A> fa) => fa.toString();
}

class OptionTEq<F, A> implements Eq<OptionT<F, A>> {
  const OptionTEq();

  @override
  bool eqv(OptionT<F, A> fa, OptionT<F, A> fb) => fa == fb;
}

//class OptionTApplicativeErrorF<F, E>
//     with
//         Invariant<Kind<ForOptionT, F>>,
//         Functor<Kind<ForOptionT, F>>,
//         Apply<Kind<ForOptionT, F>>,
//         Applicative<Kind<ForOptionT, F>>,
//         Monad<Kind<ForOptionT, F>>,
//         ApplicativeError<Kind<ForOptionT, F>, E> {
//   final MonadError<F, E> ME;

//   OptionTApplicativeErrorF(this.ME);

//   @override
//   Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(ME.pure(Option.of(a)));

//   @override
//   Kind<Kind<ForOptionT, F>, B> flatMap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, B> f(A a)) =>
//       fa.fix().flatMap(ME, f);

//   @override
//   Kind<Kind<ForOptionT, F>, A> raiseError<A>(E e) => OptionT(ME.raiseError(e));

//   @override
//   Kind<Kind<ForOptionT, F>, A> handleErrorWith<A>(
//           Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, A> f(E e)) =>
//       OptionT(ME.handleErrorWith(fa.fix().value, (e) => f(e).fix().value));
// }

// class OptionTApplicativeError<F>
//     with
//         Invariant<Kind<ForOptionT, F>>,
//         Functor<Kind<ForOptionT, F>>,
//         Apply<Kind<ForOptionT, F>>,
//         Applicative<Kind<ForOptionT, F>>,
//         Monad<Kind<ForOptionT, F>>,
//         ApplicativeError<Kind<ForOptionT, F>, Unit> {
//   final Monad<F> MF;

//   OptionTApplicativeError(this.MF);

//   @override
//   Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(MF.pure(Option.of(a)));

//   @override
//   Kind<Kind<ForOptionT, F>, B> flatMap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, B> f(A a)) =>
//       fa.fix().flatMap(MF, f);

//   @override
//   Kind<Kind<ForOptionT, F>, A> raiseError<A>(Unit e) => OptionT.none(MF);

//   @override
//   Kind<Kind<ForOptionT, F>, A> handleErrorWith<A>(
//           Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, A> f(Unit e)) =>
//       OptionT(
//         MF.flatMap(
//             fa.fix().value,
//             (Option<A> option) => option.fold(
//                   () => f(Unit()).fix().value,
//                   (a) => MF.pure(Option.of(a)),
//                 )),
//       );
// }

// class OptionTMonad<F>
//     with
//         Invariant<Kind<ForOptionT, F>>,
//         Functor<Kind<ForOptionT, F>>,
//         Apply<Kind<ForOptionT, F>>,
//         Applicative<Kind<ForOptionT, F>>,
//         Monad<Kind<ForOptionT, F>> {
//   final Monad<F> MF;
//   OptionTMonad(this.MF);

//   @override
//   Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(MF.pure(Option.of(a)));

//   @override
//   Kind<Kind<ForOptionT, F>, B> flatMap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, B> f(A a)) =>
//       fa.fix().flatMap(MF, f);
// }

// class OptionTApplicative<F>
//     with
//         Invariant<Kind<ForOptionT, F>>,
//         Functor<Kind<ForOptionT, F>>,
//         Apply<Kind<ForOptionT, F>>,
//         Applicative<Kind<ForOptionT, F>> {
//   final Monad<F> MF;
//   OptionTApplicative(this.MF);

//   @override
//   Kind<Kind<ForOptionT, F>, B> map<A, B>(
//           Kind<Kind<ForOptionT, F>, A> fa, B f(A a)) =>
//       fa.fix().map(MF, f);

//   @override
//   Kind<Kind<ForOptionT, F>, A> pure<A>(A a) => OptionT(MF.pure(Option.of(a)));

//   @override
//   Kind<Kind<ForOptionT, F>, B> ap<A, B>(Kind<Kind<ForOptionT, F>, A> fa,
//           Kind<Kind<ForOptionT, F>, B Function(A)> ff) =>
//       fa.fix().ap(MF, ff);
// }
