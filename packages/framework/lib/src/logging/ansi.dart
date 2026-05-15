const reset = '\x1B[0m';
const bold = '\x1B[1m';
const dim = '\x1B[2m';
const red = '\x1B[31m';
const green = '\x1B[32m';
const yellow = '\x1B[33m';
const blue = '\x1B[34m';
const cyan = '\x1B[36m';

final ansiPattern = RegExp(r'\x1B\[[0-9;]*m');

String stripAnsi(String s) => s.replaceAll(ansiPattern, '');
