// 6488025 Thitiwut Harnnphatcharapanukorn Sec. 1
int? readFile() {
  return null;
}
void main() {
// null-aware assertion
int? a = readFile();
a = a??0;
a = a +1;
print('a is $a');
}