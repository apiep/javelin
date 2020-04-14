import 'package:javelin/src/datatype/datatype_core.dart';
import 'package:test/test.dart';

import '../../gen.dart';
import '../../law.dart';
import '../../typeclass/laws/applicative_error_laws.dart';
import '../../typeclass/laws/applicative_laws.dart';
import '../../typeclass/laws/eq_laws.dart';
import '../../typeclass/laws/functor_laws.dart';
import '../../typeclass/laws/invariant_laws.dart';
import '../../typeclass/laws/monad_error_laws.dart';
import '../../typeclass/laws/monad_laws.dart';
import '../../typeclass/laws/show_laws.dart';

Iterable<Law> optionLaws() sync* {
  yield* ShowLaws.laws(
    Option.show(),
    Option.eq<int>(),
    Option.applicative().pure,
  );
  yield* EqLaws.laws(
    Option.eq<int>(),
    Option.applicative().pure,
  );
  yield* InvariantLaws.laws(
    Option.invariant(),
    Option.eq<int>(),
    Option.applicative().pure,
  );
  yield* FunctorLaws.laws(
    Option.functor(),
    Option.eq<int>(),
    Option.applicative().pure,
  );
  yield* ApplicativeLaws.laws(
    Option.applicative(),
    Option.eq<int>(),
  );
  yield* ApplicativeErrorLaws.laws(
    Option.applicativeError(),
    Option.eq<int>(),
    Option.eq<Either<Unit, int>>(),
    Gen.unit(),
  );
  yield* MonadLaws.laws(
    Option.monad(),
    Option.eq<int>(),
  );
  yield* MonadErrorLaws.laws(
    Option.monadError(),
    Option.eq<int>(),
    Gen.unit(),
  );
}

void main() {
  group('Option type', () {
    optionLaws().check();
  });
}
