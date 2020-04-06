import 'package:javelin/javelin_typeclass.dart';
import 'package:javelin/src/core.dart';

import '../../gen.dart';
import '../../quick_check.dart';
import '../../law.dart';

class ApplicativeLaws {
  static Iterable<Law> laws<F>(Applicative<F> AP, Eq<Kind<F, int>> EQ) sync* {
    yield Law('Applicative Laws: ap identity', () => apIdentity(AP, EQ));
    yield Law('Applicative Laws: homomorphism', () => homomorphism(AP, EQ));
    yield Law('Applicative Laws: interchange', () => interchange(AP, EQ));
    yield Law('Applicative Laws: map derived', () => mapDerived(AP, EQ));
  }

  static void apIdentity<F>(Applicative<F> AP, Eq<Kind<F, int>> EQ) =>
      check(forall(
        IntGen().map(AP.pure),
        (Kind<F, int> fa) =>
            AP.ap<int, int>(fa, AP.pure(identity)).equalUnderTheLaw(EQ, fa),
      ));

  static void homomorphism<F>(Applicative<F> AP, Eq<Kind<F, int>> EQ) =>
      check(forall2(
        FunctionAtoB.gen(IntGen()),
        IntGen(),
        (int Function(int) f, int a) =>
            AP.ap(AP.pure(a), AP.pure(f)).equalUnderTheLaw(EQ, AP.pure(f(a))),
      ));

  static void interchange<F>(Applicative<F> AP, Eq<Kind<F, int>> EQ) => check(
        forall2(
            FunctionAtoB.gen(IntGen()).map(AP.pure),
            IntGen(),
            (Kind<F, int Function(int)> fa, int a) =>
                AP.ap(AP.pure(a), fa).equalUnderTheLaw(
                      EQ,
                      AP.ap(fa, AP.pure((int Function(int) x) => x(a))),
                    )),
      );

  static void mapDerived<F>(Applicative<F> AP, Eq<Kind<F, int>> EQ) =>
      check(forall2(
          IntGen().map(AP.pure),
          FunctionAtoB.gen(IntGen()),
          (Kind<F, int> fa, int Function(int) f) =>
              AP.map(fa, f).equalUnderTheLaw(EQ, AP.ap(fa, AP.pure(f)))));
}
