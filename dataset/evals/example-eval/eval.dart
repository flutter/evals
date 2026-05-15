Dataset main() {
  var evals = [ExampleEval()];

  return Dataset(evals: evals);
}

class ExampleEval extends Eval {}

class Dataset {}


// TODO: We should have a separate Dataset package?