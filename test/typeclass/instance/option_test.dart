import 'package:javelin/javelin_datatype.dart';
import 'package:javelin/javelin_extension.dart';
import 'package:test/test.dart';

import '../laws/applicative_laws.dart';
import '../laws/eq_laws.dart';
import '../laws/functor_laws.dart';
import '../../law.dart';
import '../laws/invariant_laws.dart';
import '../laws/monad_laws.dart';
import '../laws/show_laws.dart';

Iterable<Law> optionLaws() sync* {
  yield* ShowLaws.laws(
    Option.show(IntJ.show()),
    Option.eq<int>(IntJ.eq()),
    Option.applicative().pure,
  );
  yield* EqLaws.laws(
    Option.eq<int>(IntJ.eq()),
    Option.applicative().pure,
  );
  yield* InvariantLaws.laws(
    Option.invariant(),
    Option.eq<int>(IntJ.eq()),
    Option.applicative().pure,
  );
  yield* FunctorLaws.laws(
    Option.functor(),
    Option.eq<int>(IntJ.eq()),
    Option.applicative().pure,
  );
  yield* ApplicativeLaws.laws(
    Option.applicative(),
    Option.eq<int>(IntJ.eq()),
  );
  yield* MonadLaws.laws(
    Option.monad(),
    Option.eq<int>(IntJ.eq()),
  );
}

void main() {
  group('Option type', () {
    optionLaws().check();
  });
}
