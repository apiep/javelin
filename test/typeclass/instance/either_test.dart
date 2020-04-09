import 'package:javelin/javelin_datatype.dart';
import 'package:test/test.dart';

import '../../law.dart';
import '../laws/applicative_error_laws.dart';
import '../laws/applicative_laws.dart';
import '../laws/eq_laws.dart';
import '../laws/functor_laws.dart';
import '../laws/invariant_laws.dart';
import '../laws/monad_laws.dart';
import '../laws/show_laws.dart';

Iterable<Law> eitherLaws() sync* {
  yield* ShowLaws.laws(
    Either.show(),
    Either.eq<String, int>(),
    Either.applicative<String>().pure,
  );
  yield* EqLaws.laws(
    Either.eq<String, int>(),
    Either.applicative<String>().pure,
  );
  yield* InvariantLaws.laws(
    Either.invariant<String>(),
    Either.eq<String, int>(),
    Either.applicative<String>().pure,
  );
  yield* FunctorLaws.laws(
    Either.functor<String>(),
    Either.eq<String, int>(),
    Either.applicative<String>().pure,
  );
  yield* ApplicativeLaws.laws(
    Either.applicative<String>(),
    Either.eq<String, int>(),
  );
  yield* ApplicativeErrorLaws.laws(
      Either.applicativeError<Exception>(),
      Either.eq<Exception, int>(),
      Either.eq<Exception, Either<Exception, int>>());
  yield* MonadLaws.laws(
    Either.monad<String>(),
    Either.eq<String, int>(),
  );
}

void main() {
  group('Either type', () {
    eitherLaws().check();
  });
}
